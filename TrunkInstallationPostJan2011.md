Note: these instructions currently apply to the trunk code on or after 2011-01-21.
For previous trunk code or one of the current releases see [Installation](Installation.md).

**_Table of Contents:_**


# Introduction #

BibApp is a [Ruby on Rails](http://www.rubyonrails.org/) 2.3 web application.  If you are familiar with installing Ruby on Rails applications, BibApp should be no different!  If this is your first time with Ruby on Rails, don't worry...we've tried to make things easy on you.

At a basic level, Ruby on Rails applications require the following:
  * A Web server
  * A Database
  * Ruby and..
  * Rails

Currently, because of a small development/testing team, we have some recommendations for your Rails setup for BibApp.  You may be able to get away with other non-recommended Ruby on Rails setups.  But, we haven't verified they all work with BibApp, yet.

So, without further ado...

# Software Pre-requisities #

BibApp should run on any Operating System.  Currently we've had it successfully running on Linux, Mac OS X and Windows XP.
  * _Note:_ Although BibApp will run on Windows, it is not recommended for production on Windows systems.  BibApp runs slightly slower on Windows as the backend, asynchronous processing functionality that BibApp uses doesn't currently work for Windows.

BibApp **requires** the following software to function properly:

  * [Ruby](http://www.ruby-lang.org/) 1.8.7 (**For best results in Production** we recommend http://www.rubyenterpriseedition.com/ Ruby Enterprise Edition)
    * Check your version by running `ruby --version` at command line
    * [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/) 1.8.7 is highly suggested for Production. It is more stable and faster than normal Ruby.
  * [RubyGems](http://www.rubygems.org/) 1.3.5 or later
    * Check your version by running `gem --version` at command line
    * If you have an older version of RubyGems, you should be able to update it like this:
```
      gem update --system
```
    * After Ruby Gems is installed, remember to enable it by adding the following to your system's `PATH`:
```
      RUBYOPT=rubygems
```
  * [Java](http://java.sun.com/javase/downloads/index.jsp) 1.5 or later (_note:_ Java 1.5 is also sometimes called Java 5.x, similarly Java 1.6 is also called 6.x)
    * Check your version by running `java -version` at command line
  * **A Database:** BibApp gives you a few options when it comes to your database.  Currently, we support either of the following:
    * [MySQL](http://www.mysql.com/) 4.1 or 5.0+, OR
    * [PostgreSQL](http://www.postgresql.org/) 8.x (7.4 may also work, though it's untested. It's likely that 9.x will also work, though that is also untested.)
    * NOTE: The below section on [Install Database Software](#2._Install_Database_Software.md) can help you install and configure your database software of choice.
  * **A Web Server:** We recommend one of two possible web server setups, as documented below in [Install Web Server](#3._Install_Web_Server.md).
  * [Subversion (svn)](http://subversion.tigris.org/) - a Subversion client will be needed to get the trunk code.

That's everything you need to get started...

# OS-specific Installation Guides #

The following guides are from the previous installation instructions. They may still contain helpful information, but you'll want to use them in conjunction with this page.

## Red Hat Enterprise Linux 4 ##

> | **Note:** The RHEL instructions include BibApp installation and configuration instructions as well. Many will apply to other Unix-like operating systems. |
|:----------------------------------------------------------------------------------------------------------------------------------------------------------|

Installation instructions for RHEL4 (by Illinois) - [InstallationRHEL4](InstallationRHEL4.md).

## Ubuntu Linux ##

> | **Recently updated!** |
|:----------------------|

Installation instructions for Ubuntu (by Illinois) - [InstallationUbuntuLinux](InstallationUbuntuLinux.md).

## Solaris ##

Installation instructions for Solaris (by Wisconsin) - [InstallationSolaris](InstallationSolaris.md).

## Mac OSX ##

Installation instructions for Mac OSX (Leopard and Snow Leopard) - [InstallationMacOSX](InstallationMacOSX.md).

# General Installation Instructions #

These installation instructions are purposely written to be no-specific.  They are meant as a guide for administrators who are trying to install BibApp on an operating system which is not listed above.

## Before We Get Started ##

Before we jump in, it's worth explaining a bit about what software BibApp has bundled (Rails uses the term "frozen") within it.  You don't need to understand what everything is doing, but we just want to let you know it's there! When you download BibApp, it already comes pre-packaged with the following:
  * [Solr](http://lucene.apache.org/solr/) - Used for all the BibApp browse/search interfaces
  * A variety of [Ruby Gems](http://www.rubygems.org/) and Rails Plugins. It's worth highlighting a few custom plugins created specifically for BibApp:
    * `citation_parser` and `citation_importer` - These custom plugins parse citations from our various supported input formats, and import the data into our database structure.  As more citation parsers are created, we'll be able to support more input formats!
    * `sword_client` - This is our custom [SWORD (Simple Web-service Offering Repository Deposit)](http://www.swordapp.org) client.  It lets you deposit research (both metadata and files) into your local repository directly from BibApp!

## 1. Download BibApp Code ##

  1. With Subversion installed, just pull down the latest code (the below example checks it out to your `~/bibapp/` directory):
```
    svn checkout http://bibapp.googlecode.com/svn/trunk/ ~/bibapp/
```

**Note:** Throughout the remainder of these instructions we use the placeholder `[bibapp]` to represent the location where you have downloaded the BibApp code!

## 2. Install Database Software ##

BibApp gives you a few options when it comes to your database.  Currently, we support either of the following:
  * [MySQL](http://www.mysql.com/)
> OR
  * [PostgreSQL](http://www.postgresql.org/)

Visit the appropriate website above to install the database of your choice.

**CHOOSE ONLY ONE DATABASE TO INSTALL.**

### Add Database Scripts to PATH ###

For some operating systems, you may need to modify your `PATH` environment variable to reference the location of the newly installed database's scripts (usually in a `bin/` sub-directory of the database installation location).

For example:
```
PATH="$PATH:/full/path/to/database/directory/bin"
```

**NOTE:** Many one-click installers will do this for you.  So, if you downloaded an auto-installer, it's likely you don't need to worry about this step.

Later we'll install a driver to use the database from Ruby.

## 3. Install Web Server ##

BibApp requires a web server that understands Ruby/Rails to run.  There are two main options available:

  * [Thin](http://code.macournoyer.com/thin/) (Development/Demo)
    * Thin is a lightweight webserver that is convenient for development work and that integrates easily with Rails (via Rack). By running several thin servers behind a load balancing proxy (e.g. Apache or Nginx) it may also be used for production, but that is beyond the scope of this document.
  * [Phusion Passenger](http://www.modrails.com/) and [Apache 2](http://httpd.apache.org/) (Production)

See below for instructions on installing your web server of choice.

**CHOOSE ONLY ONE WEB SERVER TO INSTALL.**

### How to Install Thin (Development/Demo) ###

Thin will automatically be installed when we install the other gems.

### How to Install Passenger and Apache (Production) ###

#### Install Apache 2 ####

First, you will need to download and install [Apache 2 webserver](http://httpd.apache.org/).  If you do a Google search for "Apache 2" and your operating system, you should be able to find some useful instructions.

#### Install Passenger Module ####

Note: I haven't tried this since switching to bundler for the gems. The instructions may require some modification in that case.

Next, you'll need to install Passenger, which is an Apache module that allows Apache to run Ruby on Rails applications.  Run the following from the command line:
```
  gem install -r passenger
  passenger-install-apache2-module
```

The last command will report several lines of instructions at the end.  Follow these instructions to configure Apache so that it loads the new Passenger module.  Below are the general instructions, but you may need to change version numbers or paths for your system:

  * Edit the Apache `httpd.conf` file (likely at `/etc/apache2/` or `/etc/httpd/` or similar) in the editor of your choice.
  * Add the following to enable Passenger in `httpd.conf` (You may need to modify paths or version numbers below!):
```
    LoadModule passenger_module /full/path/to/gems/passenger-[VERSION]/ext/apache2/mod_passenger.so
    PassengerRoot /full/path/to/gems/passenger-[VERSION]
    PassengerRuby /full/path/to/ruby
```
  * Add the following Virtual Host and Directory settings to `httpd.conf`:
```
     <VirtualHost *:80>
        ServerName localhost
        DocumentRoot [bibapp]/public
     </VirtualHost>

     <Directory "[bibapp]/public">
        Options ExecCGI FollowSymLinks
        AllowOverride all
        Allow from all
     </Directory>
```
  * Restart Apache web server


## 4. Configure BibApp ##

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


## 5. Ruby Gem Installations ##

In addition to gems explicitly bundled with the BibApp source code we need to
install some other gems. We use the Bundler gem to do this in a straightforward way. If you do not already have the bundler gem installed, then install it:

```
gem install bundler
```

Bundler will then use the file `[bibapp]/Gemfile` in the code checkout to install all of the necessary gem requirements.

If you are using mysql, edit `[bibapp]/Gemfile` and replace the line:

```
gem 'pg'
```

with

```
gem 'mysql'
```

You can then install all the gems (including the database drive and the thin webserver) by:

```
bundle install
```

If your database is installed to a non-standard location you may see some errors when you do this. In this case you'll need to let bundler know where the installation is located (replace 'mysql' with 'pg' if appropriate):

```
bundle config build.mysql --with-mysql-config=/path/to/mysql_config
bundle install
```


### Common Warnings / Errors ###

| **Error / Warning Message** | **Resolution** |
|:----------------------------|:---------------|
| Log File Warning:<br />`Rails Error: Unable to access log file.  Please ensure that /bibapp/log/development.log exists and is chmod 0666.` | Make sure to change the permissions on this log file, so that it is both _readable_ and _writeable_ to everyone.  For example: `chmod 0666 development.log` |
| Error building `libxml-ruby` gem:<br /> `ERROR: Failed to build gem native extension` | _For Ubuntu/Debian:_ You should be able to resolve this error by installing `libxml2` and `libxml2-dev`: (e.g.) `sudo apt-get install libxml2 libxml2-dev` |
| Loading error:<br /> `'require': no such file to load -- mkmf (LoadError)` | _For Ubuntu/Debian:_ You should be able to resolve this error by installing the latest Ruby development package (`ruby1.8-dev`): (e.g.) `sudo apt-get install ruby1.8-dev` |
|Error building `eventmachine` gem<br /> `ERROR: Failed to build gem native extension` |_For Solaris:_ You should be able to resolve this error by setting a CXX environment variable to g++ and then running `bundle install` again: (e.g.) `sudo export CXX=g++` |

## 6. Initialize Your BibApp Database ##

Now, you'll need to setup a database for BibApp.  You should already have installed either MySQL or PostgreSQL.  So, it's just a matter of creating a new database!

Assuming that you've set database names, users, and passwords (if needed) in your
database.yml file, you should be able to do:

```
rake db:create:all
```

to create a database for each environment that you've defined. If you only want to do it for a specific environment, then you should be able to do (replacing test with the appropriate environment):

```
RAILS_ENV=test rake db:create
```

  * **For MySQL:**  (Untested, but based on previous instructions - useful if a MySQL user could weigh in on this) You may have to do a bit more work to get the permissions right. Assuming you've created bibapp\_development database with user/password bibapp/bibapppw. You may need to something like:
```
      GRANT ALL ON bibapp_development.* to 'bibapp'@'localhost' identified by 'bibapppw';
      FLUSH PRIVILEGES;
```


Now you can generate the BibApp database structure into your new database!  Here there are two options:

  * From within your `[bibapp]` directory:
```
    rake db:schema:load
```
You should see a large number of 'create table' messages scroll by.  That's perfectly normal! But, if any errors appear, there are problems which you will have to resolve **before** BibApp will function properly!
  * **OR** You can also run the migrations. One of the migrations requires that solr is running, though. Since you've already configured solr, you can do:

```
   rake solr:start
   rake db:migrate
   rake solr:stop
```

Either of these should give the same result, assuming that the schema.rb file is kept up to date.

Before continuing, you also need to initialize your database with an Administrator account and the current [SHERPA RoMEO](http://www.sherpa.ac.uk/romeo.php) publisher policy data.  This data is used to help researchers determine which of their publications can be deposited in a local repository for safe keeping.  From within your `[bibapp]` directory:
```
    rake db:seed
```

Your database should now be setup and initialized properly!


## 7. Startup BibApp ##

You're almost there!

### For Passenger + Apache Installs (Production) ###

If you installed Passenger + Apache to run BibApp, just run the following from your `[bibapp]` directory:
```
rake bibapp:start
```

Try it out! BibApp should now be available at:  http://localhost/

### For Thin Installs (Development/Demo) ###

If you are using Thin to run a development version of BibApp, just run the following from your `[bibapp]` directory:
```
rake bibapp:start
bundle exec thin start
```

(Note: It is important to do `bundle exec thin start` and not simply `thin start`. The latter may cause gem dependency problems.)

Try it out! BibApp should now be available at:  http://localhost:3000/


# Using BibApp #

## Login For the First Time ##

BibApp comes with a pre-initialized "admin" user.  The login for this user is "admin" (lowercase), and the default password is "bibapp" (lowercase).

This "admin" user has System Administrator rights, and can do anything within BibApp.  Therefore, it is _absolutely necessary_ to **login and change the password** for this user as soon as possible.

_Repeat:_ it is _absolutely necessary_ to **login and change the password** for this user as soon as possible.

So, login and do it now!

  1. After logging in, click on "Welcome: admin" in the upper right, to view your "admin" user's account information.
  1. Click "Change Password", and fill out the default password along with your new password

Finally, (although not required at this time) you may wish to change the email account associated with this "admin" user.   At this time, BibApp only uses that email address if you have forgotten your password and request a new one be generated.   So, if you have any concerns about forgetting your "admin" user's password, change the email to point to a valid email address!

# Problems / Questions / More Information #

We're definitely aware that these instructions are a bit lacking. If you run into any interesting problems or "gotchas" during the installation or setup, let us know!

The easiest (and preferred) way to contact us is via our [BibApp Google Group](http://groups.google.com/group/bibapp).

If you ran into problems during the installation, try and send us the following:
  * Ruby version (run `ruby --version`)
  * Gem version (run `gem --version`)
  * Operating system
  * Task/step you were performing
  * Error message text