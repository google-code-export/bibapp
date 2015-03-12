#Capistrano installation

# Introduction #

Capistrano is a tool that makes it easy to deploy and update applications on remote servers. We have set Bibapp up so that you can use Capistrano to manage your Bibapp
deployment.

This guide is still rough, and will deal primarily with how to deal with capistrano + passenger.

# Details #

## Configure Capistrano ##

> Install capistrano on your development machine. You can do this by doing:

```
 gem install capistrano
```

> Edit capistrano deployment file

Copy config/deploy.rb.template to config/deploy.rb in your development machine. Here are a variety of settings that control how Capistrano will control your deployment. You'll need to change some of the settings marked with 'set' or 'role'. Important ones include:

  * set :deploy\_to - change to the directory on your server where you want Bibapp to live. If you are upgrading from a non-capistrano deployment then I recommend that you make this different than your current directory. By default there will (eventually) be three directories under this one: releases, which will contain code checkouts of various releases of the Bibapp code - current, which will symlink to one of the releases (the active one) - and shared, which will contain data that persists between deployments, e.g. configuration files from config/ and attachments from public/attachments. Upon deployment of new releases capistrano, via its own magic and that of the config/deploy.rb file, will make sure that these assets are linked or copied correctly to the new checkout of the code. I'll call this directory [deploy\_to](deploy_to.md) below.
  * set :user - change to the user that will be running Bibapp on the server. You will need for the ssh public key from your development machine to be in the authorized\_keys for this user on the server
  * role :web, role :app, role :db - in a typical Bibapp installation these may all be set to the same machine; however, the main web server (e.g. Apache running passenger), application server(s) (the actual running instances of Rails with Bibapp loaded up), and database server(s) may be different.

This should be all you need to do, but Capistrano has other settings if you need them.

## Deploy code ##

On your development machine, inside your Bibapp project, do

```
   cap deploy:setup
```

You should see something like this:

```
cap deploy:setup
  * executing `deploy:setup'
  * executing "mkdir -p /services/ideals-bibapp/bibapp-capistrano /services/ideals-bibapp/bibapp-capistrano/releases /services/ideals-bibapp/bibapp-capistrano/shared /services/ideals-bibapp/bibapp-capistrano/shared/system /services/ideals-bibapp/bibapp-capistrano/shared/log /services/ideals-bibapp/bibapp-capistrano/shared/pids &&  chmod g+w /services/ideals-bibapp/bibapp-capistrano /services/ideals-bibapp/bibapp-capistrano/releases /services/ideals-bibapp/bibapp-capistrano/shared /services/ideals-bibapp/bibapp-capistrano/shared/system /services/ideals-bibapp/bibapp-capistrano/shared/log /services/ideals-bibapp/bibapp-capistrano/shared/pids"
    servers: ["sophia.cites.illinois.edu"]
    [sophia.cites.illinois.edu] executing command
    command finished
    triggering after callbacks for `deploy:setup'
  * executing `deploy:create_shared_dirs'
  * executing "mkdir /services/ideals-bibapp/bibapp-capistrano/shared/config"
    servers: ["sophia.cites.illinois.edu"]
    [sophia.cites.illinois.edu] executing command
    command finished
  * executing "mkdir /services/ideals-bibapp/bibapp-capistrano/shared/system/attachments"
    servers: ["sophia.cites.illinois.edu"]
    [sophia.cites.illinois.edu] executing command
    command finished
  * executing "mkdir /services/ideals-bibapp/bibapp-capistrano/shared/system/groups"
    servers: ["sophia.cites.illinois.edu"]
    [sophia.cites.illinois.edu] executing command
    command finished
  * executing "mkdir /services/ideals-bibapp/bibapp-capistrano/shared/system/people"
    servers: ["sophia.cites.illinois.edu"]
    [sophia.cites.illinois.edu] executing command
    command finished

```

Capistrano is simply creating the directory structure it needs on your server. You can verify this by logging into your server and looking at [deploy\_to](deploy_to.md).

Next you need to deal with configuration files.

If you are migrating, you'll want to go to the config directory of your old installation and copy the following files into [deploy\_to](deploy_to.md)/shared/config : database.yml, ldap.yml, smtp.yml, solr.yml, sword.yml, personalize.rb. If you skipped any of these in your deployment, you can skip them here as well.

If you are doing a new deployment, then you'll want to copy your development versions over to [deploy\_to](deploy_to.md)/shared/config on your server and modify them as necessary for your production environment.

Next you'll actually check out the code onto the server. As a prerequisie you'll
need to have the bundler gem installed on the server. If you need to do this, then
from the server do:

```
 gem install bundler
```

If your version of ruby gems is too old you'll need to precede this with:

```
 gem update --system
```

Now from the development machine:

```
  cap deploy:update_code
```

This will checkout the latest version of the code into [deploy\_to](deploy_to.md)/releases/XYZ, where XYZ is basically a timestamp. It will link [deploy\_to](deploy_to.md)/current to this checkout directory. Bundler will install any gems that are needed.

If you are migrating, at this point you may want to shutdown your old copy of bibapp. On the server (if you have apache serving more than Bibapp you may want to be more circumspect here):

```
 apachectl stop
 rake bibapp:stop (from the old bibapp directory on the server)
```

If you are migrating you may want to backup your production database (database dependent - no instructions here). From your development machine:

```
  cap deploy:migrate
```

This will run any database migrations since your old checkout.

If this is a new installation, then you'll need to login to the server first and create the database. You should be able to do this by changing to the [deploy\_to](deploy_to.md)/current directory on the server and running:

```
  RAILS_ENV=production rake db:create
```

Then from the development machine:

```
  cap deploy:migrate
```

which will create the database structure you need. Back on the server you'll then
need to do

```
  RAILS_ENV=production rake db:seed
```

For a migration, you'll now need to go to the public directory in your old bibapp installation. From there copy or move the attachments, groups, and people subdirectories into [deploy\_to](deploy_to.md)/shared/system. (If you have other customizations you can get capistrano to deal with them as well, but that's beyond the scope of this guide for now).

We're almost done. You can either modify the apache configuration on your server now so that the passenger root is correct for the new capistrano installation (for a new installation consult the section on passenger elsewhere on this wiki). E.g. you'd be changing:

```
 .../old_bibapp_dir/public
```

to

```
   [deploy_to]/current/public
```

As an alternative if Apache is configured to allow transversal of symlinks you can move old\_bibapp\_dir somewhere else and then symlink [deploy\_to](deploy_to.md)/current to old\_bibapp\_dir.

Now you should be able to do on the server:

```
 apachectl start
```

For simplicity I recommend now doing (from your development machine):

```
  cap deploy
```

This will deploy another checkout of the code, but it should also make sure that the 'rake bibapp:start' task is run on the server.

Now whenever you want to deploy a new version of the code to the server, on your development machine you can just do:

```
  cap deploy
  cap deploy:migrate (only necessary when there are new migration, but it doesn't hurt to run it)
```

This will stop Bibapp, check out the new code, run migrations, link/copy all the shared assets/configuration, restart bibapp, reindex, point passenger at the new copy of the code, and restart passenger.

If you do:

```
  cap -T
```

you'll see a variety of other things you can do. For example, from your development machine you can start/stop bibapp, force a solr reindexing, or remove old checkouts of the code once you're confident that the new one is working correctly (you have to do this manually, and even when you do by default a few old copies are kept around).