**_Table of Contents:_**


# Install Introduction #

The below instructions are based on a fresh installation of BibApp on Mac OSX 10.6 (Snow Leopard).  They should also work on 10.5 (Leopard), and I've added notes detailing some known differences on Leopard.

Before we begin, a few notes:
  * These instructions are based on a MacBook Pro installation, for a basic development environment.  These instructions attempt to use as much pre-installed software as possible to simplify the install process.  Therefore, they may not be tailored to Production level installs on Mac OSX Servers.
  * You must be comfortable with using the Terminal (`/Applications/Utilities/Terminal`) to install BibApp on Mac OSX.


## Ruby on Rails Resources for Mac OSX ##

Here are a few good online guides which detail how to install Ruby on Rails applications on Leopard and Snow Leopard.  As BibApp is a Ruby on Rails application, these guides can be useful tools to get your initial pre-requisities installed.

  * Ruby on Rails on Leopard (10.5)
    * http://hivelogic.com/articles/ruby-rails-leopard
  * Ruby on Rails on Snow Leopard (10.6)
    * http://hivelogic.com/articles/compiling-ruby-rubygems-and-rails-on-snow-leopard/


# Software Pre-Requisities #

_Check the latest required versions of the below software from the [Software Pre-Requisities](Installation#Software_Pre-requisities.md) section of the primary Installation documentation._

  * [Ruby](http://www.ruby-lang.org/)
    * Check your version by running `ruby --version` from Terminal
    * Ruby 1.8.6 comes with Leopard (10.5)
    * Ruby 1.8.7 comes with Snow Leopard (10.6)
    * **NOTE:** Production installations should look into installing [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/) as it provides better stability and speed than basic Ruby.
  * [RubyGems](http://www.rubygems.org/)
    * Check your version by running `gem --version` at command line
    * If you have an older version of RubyGems, you should be able to update it like this:
```
      sudo gem update --system
```
  * [Java](http://java.sun.com/javase/downloads/index.jsp) 1.5 or later (_note:_ Java 1.5 is also sometimes called Java 5.x, similarly Java 1.6 is also called 6.x)
    * Check your version by running `java -version` at command line
    * Java 1.5 comes with Leopard (10.5)
    * Java 1.6 comes with Snow Leopard (10.6)
  * **A Database:** BibApp gives you a few options when it comes to your database.  Currently, we support either of the following:
    * [MySQL](http://www.mysql.com/) 4.1 or 5.0+, OR
    * [PostgreSQL](http://www.postgresql.org/) 8.x (7.4 may also work, though it's untested)
    * The below section on [Install Database Software](#Install_Database_Software.md) can help you install and configure your database software of choice.
  * **A Web Server:** There are two possible web server setups.  A Development one, and a Production one:
    * [Mongrel](http://mongrel.rubyforge.org/) (Development/Demo only)
      * **Never run Mongrel in Production** as it can only handle one request at a time!
    * [Phusion Passenger](http://www.modrails.com/) and [Apache 2](http://httpd.apache.org/) (Production)
    * The below section on [Install Web Server](#Install_Web_Server.md) can help you install and configure your web server software of choice.


_Optional:_ If you want to be able to pull down BibApp directly from our GoogleCode site, you may also wish to install [Subversion (svn)](http://subversion.tigris.org/).
  * Subversion (`svn`) comes with Leopard and Snow Leopard

# Additional Mac OSX Pre-Requisities #

You'll need to install [Apple's XCode tools](http://developer.apple.com/Tools/xcode/), as it includes various developer tools needed to build some of the Ruby Gems that BibApp uses.  You can find the Apple XCode tools in the Optional Installs / Xcode Tools directory on the Leopard DVD, or via the above link on the Apple website.

In addition, you should add the following to your user's `~/.profile` or `~/.bash_profile` file, to ensure Mac OSX can locate all Ruby binaries:
```
# Add /usr/local/ directories to path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
```


# Download BibApp Code #

There are two different ways to install BibApp:

  1. (Recommended ) you can just pull down the latest code (the below example checks it out to your user's `~/bibapp/` directory):
```
    svn checkout http://bibapp.googlecode.com/svn/trunk/ ~/bibapp/
```
  1. Otherwise, you can download the latest Zipped up release from the [Downloads](http://code.google.com/p/bibapp/downloads/list)

> | **Note:** Throughout the remainder of these instructions we use the placeholder `[bibapp]` to represent the location where you have downloaded the BibApp code! |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|


# Install Database Software #

BibApp gives you a few options when it comes to your database.  Currently, we support either of the following:
  * [MySQL](http://www.mysql.com/)
> OR
  * [PostgreSQL](http://www.postgresql.org/)

See below for instructions on installing your database of choice.

**CHOOSE ONLY ONE DATABASE TO INSTALL.**

## Installing MySQL on Mac OSX ##

See one of the following resources:

  * MySQL on Leopard (10.5)
    * http://hivelogic.com/articles/installing-mysql-on-mac-os-x/
  * MySQL on Snow Leopard (10.6)
    * http://hivelogic.com/articles/compiling-mysql-on-snow-leopard/

You should add the following to your user's `~/.profile` or `~/.bash_profile` file, to ensure Mac OSX can locate all MySQL scripts (change `/path/to/mysql` to appropriate path, e.g. `/usr/local/mysql`):
```
# Add /path/to/mysql directories to path
export PATH="/path/to/mysql:$PATH"
```

You will also need to install the `mysql` Gem to allow Ruby to communicate with MySQL
  * For Leopard (32-bit/i386)
```
    sudo env ARCHFLAGS="-arch i386" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
```
  * For Snow Leopard (64-bit/x86\_64)
```
    sudo env ARCHFLAGS="-arch x86_64" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config
```

## Installing PostgreSQL on Mac OSX ##

### PostgreSQL on Leopard (10.5) ###

  1. For Leopard, you can use the one-click PostgreSQL installer available from: http://www.postgresql.org/download/macosx
    * One click installer will install PostgreSQL to `/Library/PostgreSQL/`
  1. Add PostgreSQL scripts to your `PATH`.  Modify your user's `~/.profile` or `~/.bash_profile` and add the following (you may need to modify the folder path):
```
    # Add /Library/PostgreSQL/ directories to path
    export PATH="/Library/PostgreSQL/8.4/bin:$PATH"
```
  1. Install the `pg` Gem to allow Ruby to communicate with PostgreSQL.  Note the needed `ARCHFLAGS` as Leopard is a 32-bit/i386 operating system:
```
    sudo env ARCHFLAGS="-arch i386" gem install pg
```



### PostgreSQL on Snow Leopard (10.6) ###

**WARNING: DO NOT USE THE ONE CLICK INSTALLER**

**WARNING: DO NOT USE THE ONE CLICK INSTALLER**

**WARNING: DO NOT USE THE ONE CLICK INSTALLER**

The PostgreSQL one-click installer will install 32-bit PostgreSQL, which isn't compatible with 64-bit Ruby on Snow Leopard.  If you use this installer on Snow Leopard, you will be unable to use PostgreSQL with any Ruby on Rails application.

  1. Instead, you will have to compile/build PostgreSQL from source.  Your options are one of the following:
    * (_Not for faint of heart_) Compile manually from source: http://www.postgresql.org/ftp/source/
    * (_Recommended_) Use [MacPorts](http://www.macports.org/) or [Fink](http://www.finkproject.org) to build/compile it for you.  Here are some tip for installing via MacPorts (Installing via Fink should be similar, but check their documentation for more details):
      * First, install [MacPorts](http://www.macports.org/)
      * Then install PostgreSQL 8.4 (or latest version), both the client and server:
```
         sudo port install postgres84 postgres84-server
```
        * Above command installs PostgreSQL to `/opt/local/lib/postgresql84/`
      * Add PostgreSQL scripts to your `PATH`.  Modify your user's `~/.profile` or `~/.bash_profile` and add the following (you may need to modify the folder path):
```
        # Add /opt/local/lib/postgresql directories to path
        export PATH="/opt/local/lib/postgresql84/bin:$PATH"
        # Specify location of PostgreSQL database directory (may be optional)
        export PGDATA="/opt/local/var/db/postgresql84"
```
    * A few useful guides to installing PostgreSQL via MacPorts:
      * http://shifteleven.com/articles/2008/03/21/installing-postgresql-on-leopard-using-macports
      * http://blog.marcchung.com/notes/postgres-on-macosx.html
  1. Install the `pg` Gem to allow Ruby to communicate with PostgreSQL.  Note the needed `ARCHFLAGS` as Snow Leopard is a 64-bit/x86\_64 operating system:
```
    sudo env ARCHFLAGS="-arch x86_64" gem install pg
```

# Install Web Server #

BibApp requires a web server that understands Ruby/Rails to run.  There are two main options available:
  * Mongrel (Development/Demo only)
    * **Never run Mongrel in Production** as it can only handle one request at a time!
  * [Phusion Passenger](http://www.modrails.com/) and Apache (Production)

See below for instructions on installing your web server of choice.
**CHOOSE ONLY ONE WEB SERVER TO INSTALL.**

## Install Mongrel (Development/Demo Only) ##

Again, never use Mongrel for Production.  Mongrel can only handle a single request at a time, and will slow down to an extreme crawl under Production scenarios.

Installing Mongrel is easy:
```
  sudo gem install mongrel
```

## Install Passenger and Apache (Production) ##

_These instructions are based on those available at:_ http://sheldonconaty.com/?p=58

Apache comes pre-installed on Mac OSX.  However, it is turned off by default.
Here's how to start up Mac OSX's built in Apache Web Server:
  * Go to your 'System Preferences' > 'Sharing' > 'Services' and enable 'Personal Web Sharing'.  This will start up Apache for you, and you should be able to access it by visiting http://localhost/ in your web browser.

Next, you'll need to install Passenger, which is an Apache module that allows Apache to run Ruby on Rails applications.
```
  sudo gem install -r passenger
  sudo passenger-install-apache2-module
```

The last command will report several lines of instructions at the end.  Follow these instructions to configure Apache so that it loads the new Passenger module.  Below are the general instructions, but you may need to change version numbers for your system:

  * Edit the `/etc/apache2/httpd.conf` file in the editor of your choice.  Don't forget to use `sudo` to ensure you have rights to edit it!
  * Add the following to enable Passenger in `httpd.conf` (You may need to modify paths or version numbers below!):
```
    LoadModule passenger_module /Library/Ruby/Gems/1.8/gems/passenger-2.2.9/ext/apache2/mod_passenger.so
    PassengerRoot /Library/Ruby/Gems/1.8/gems/passenger-2.2.9
    PassengerRuby /System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby
```
  * Add the following Virtual Host and Directory settings to `httpd.conf`:
```
     <VirtualHost *:80>
        ServerName localhost
        DocumentRoot /full/path/to/bibapp-user/bibapp/public
     </VirtualHost>

     <Directory "/full/path/to/bibapp-user/bibapp/public">
        Options ExecCGI FollowSymLinks
        AllowOverride all
        Allow from all
     </Directory>
```
  * Restart Apache by running the following from Terminal
```
    sudo apachectl -k restart
```


# Configure BibApp #

Next, you'll need to edit the configurations for your local settings.  In the `[bibapp]/config` directory, look for the following "example" configurations:

  * database.yml.example
  * ldap.yml.example
  * personalize.rb.example
  * smtp.yaml.example
  * solr.yml.example
  * sword.yml.example

You'll need to copy each of these files into a file _without_ the `.example` extension and personalize the contents as necessary.  Each of the above files include instructions within them describing how to configure them properly for your institution. In the end you should end up with a file list similar to the following (REQUIRED configuration files are **bold**):

  * **database.yml** - Your local database settings (take a look at the samples for both MySQL and PostgreSQL)
  * ldap.yml - Your campus LDAP directory settings
    * Setting this configuration eases the process of adding People to BibApp by allowing you to search your local LDAP directory to pre-populate person information.
    * You may disable this configuration by leaving the ".example" file extension on the file.
  * **personalize.rb** - Your BibApp personalization settings
  * **smtp.yml** - Your SMTP settings for user account creation verification emails
  * **solr.yml** - Your Solr port settings (should not require changes, unless the specified ports are already in use)
  * sword.yml - Your SWORD server settings
    * This configuration is only necessary if you have a local digital or institutional repository which supports [SWORD (Simple Web-service Offering Repository Deposit)](http://www.swordapp.org/).  If you have a repository supporting SWORD, BibApp can accept uploaded files and make deposits (of both files and metadata) directly into your local repository.
    * You may disable this configuration by leaving the ".example" file extension on the file.

# Ruby Gem Installations #

Unfortunately, we cannot bundle everything  within BibApp.  We've tried to minimize your need to install Gems, but there are still a few you'll need to install yourself:
  1. First, make sure you have `rake` installed:
```
     sudo gem list rake
```
    * If it's missing, you'll need to install `rake`:
```
     sudo gem install rake
```
  1. Auto-install all our gem pre-requisites, via this `rake` command.  This command should be run from your `[bibapp]` directory:
```
     sudo rake gems:install
```

# Initialize the BibApp Database #

First, you must create the database user and database as listed in your `[bibapp]/config/database.yml` file.  For more information on doing this, see the main Installation guide: http://code.google.com/p/bibapp/wiki/Installation#Setup_Your_Database

Next, we need to initialize and prepopulate some basic data in your BibApp database. Again, from your `[bibapp]` directory, run:

```
rake db:schema:load
rake db:seed
```

# Finally, Start up BibApp #

## For Passenger + Apache Installs (Production) ##

If you installed Passenger + Apache to run BibApp, just run the following from your `[bibapp]` directory:
```
rake bibapp:start
```

BibApp will be available at http://localhost/

## For Mongrel Installs (Development/Demo) ##

If you are using Mongrel to run a development version of BibApp, just run the following from your `[bibapp]` directory:
```
rake bibapp:start
mongrel_rails start
```

BibApp will be available at http://localhost:3000/