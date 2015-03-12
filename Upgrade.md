## Introduction ##

These upgrade instructions assume you are currently running BibApp 0.7 or greater, and wish to upgrade to the next version of BibApp.

At a basic level, this upgrade process involves the following:
  1. Backup database and installation directory
  1. Pull down new version of BibApp
  1. Update gems and database
  1. Update configs
  1. Re-index via Solr

## Backup BibApp Installation ##

**Before** you begin to even think about upgrading, you should make sure you have successfully backed up your entire BibApp installation.

Although your upgrade process _should_ go smoothly, there's always a chance something could go wrong which may or may not cause data loss.  Therefore, it's imperative that you've backed up your data before continuing.

You should backup the following:
  1. Your entire `[bibapp]` installation directory. (e.g. `cp -R bibapp/ bibapp-Backup/`)
  1. Your BibApp Database
    * Please refer to your database's backup instructions for information on how best to do this:
      * [MySQL Backup and Recovery](http://dev.mysql.com/doc/refman/5.0/en/backup-and-recovery.html)
      * [PostgreSQL Backup and Restore](http://www.postgresql.org/docs/8.1/static/backup.html)

We cannot say it enough...so, we'll say it one last time:

**Backup your BibApp Installation before continuing!**

## Shutdown BibApp ##

Before continuing with the upgrade, you should also shutdown your BibApp installation.  This requires shutting down the following:
  1. Your webserver (if you're running WEBrick or Mongrel)
  1. Solr
```
    rake solr:stop 
```
  1. delayed\_job
```
    script/delayed_job stop ENV['RAILS_ENV']
```
  * **All in one** - The simplest way to shutdown BibApp is to use the bibapp rake task, which will stop Solr and delayed\_job
```
    rake bibapp:stop 
```
  * Note: BibApp shutdown will sometimes fail. To be safe, check your process status.
```
    ps -eaf | grep solr
    ps -eaf | grep delayed
```

## Download the latest version of BibApp ##

There are two different ways to pull down the latest version of BibApp

  * If you originally used Subversion to install BibApp, you can just update your checkout similar to this:
```
    svn up
```
  * Otherwise, you can download the latest Zipped up release from the [Downloads](http://code.google.com/p/bibapp/downloads/list)

In either case you should be installing the latest version of BibApp **into your pre-existing `[bibapp]` installation directory**.  So, if you pulled down the Zip file, you will unzip it into your `[bibapp]` install directory.


## Update your Gem Dependencies ##

Rails makes it easy to update your gems to the version that BibApp requires.  Simply run the following from your `[bibapp]` directory (_only necessary when `environment.rb` is changed_):
```
rake gems:install
```

If there are any newly required gems, or any that need updating, you'll see them get installed.  If nothing is required, then nothing will happen.

## Update your Database ##

Rails also makes it easy to update your database for the new version of BibApp. Simply run the following from your `[bibapp]` directory (_only necessary when there are new migration scripts_):
```
rake db:migrate
```

This should not destroy any of your existing data.  It should just update your database structure if any changes were necessary.

## Update your BibApp Configurations ##

Unfortunately, this is a task that cannot be automated.  You'll need to look closely at the `[bibapp]/config/` directory to see if there are any new `*.example` files, or if any of the existing `*.example` files have changed.

The easiest way to tell if there are new configurations or changes in configurations are to check the latest BibApp release notes.  You'll need to make sure your existing configurations are updated appropriately.
```
TODO: ADD LINK TO RELEASE NOTES
```

## Update BibApp Solr Index ##

Just in case we've made some updates to Solr, you should make sure to re-index all of your data in Solr.  This, again, is a rather easy process.  Just start Solr back up and run the `refresh_index` command as follows:
```
rake solr:start
rake solr:refresh_index
```

## Startup BibApp and Test ##

Ok, that should be it...it's now safe to startup the BibApp again and make sure everything is working properly!
```
rake bibapp:start
```

The above command will start Solr, delayed\_job, and restart Passenger. If you've already started Solr, it will throw a warning, but will not hurt anything. **Note on Passenger** - to restart Passenger without running the bibapp rake script, simply touch `tmp/restart.txt`.