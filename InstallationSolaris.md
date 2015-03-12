Instructions for building a bibapp "zone" running: Java, Ruby, Ruby Enterprise Edition and Apache.

## Directory layout ##

The BIBAPP root is /bibapp.

/bibapp/

> build/: directory containing source and notes to rebuild the environment from scratch

> source/: source packages for installed software, libraries, etc.

> notes/: notes, copies of build process

> logs/: all application and script logs

> jdk/: the Java JDK(s)

> ruby/: the Ruby environment

> apache/: Apache webserver

> apache/content/: Apache document root

For each toolkit or application installed, there will be a sub-directory for each installed version of the software package. For example: the active Apache directory tree will be /bibapp/apache/apache-2.2.11.

## Programming languages/toolkits ##

### Java JDK ###

Java 1.6.0\_16 (/bibapp/jdk/jdk-1.6.0\_16)
> This is the Java installation to be used for the bibapp application. Please do not use any other java installations you may find on the host.

Java install notes:

  1. Get the JDK from Sun source, unpack:
    * mkdir /bibapp/build/source/jdk/jdk-6u16; cd /bibapp/build/source/jdk/jdk-6u16
    * Download, then sftp to SWAPP jdk-6u16-solaris-sparc.sh
    * Download, then sftp to SWAPP jdk-6u16-solaris-sparcv9.sh
    * chmod +x `jdk-6u16-solaris-sparc*.sh`
    * cd /bibapp/jdk
    * /bibapp/build/source/jdk/jdk-6u16/jdk-6u16-solaris-sparc.sh
    * /bibapp/build/source/jdk/jdk-6u16/jdk-6u16-solaris-sparcv9.sh
  1. Configure the JDK environment
    * Add JAVA\_HOME to ~bibappadm/.profile, modify the PATH:
```
         JAVA_HOME=/bibapp-qa/jdk/jdk-1.6.0_16
         export JAVA_HOME
         PATH=$JAVA_HOME/bin:$PATH
         export PATH
```

### Ruby ###

Ruby Enterprise Edition 1.8.7 (/bibapp/ruby/ruby-enterprise-1.8.7)
> This is the Ruby installation to be used for the bibapp ruby-on-rails application. Will contain installed third party modules.
> BibApp uses the Apache + Passenger stack to serve pages
> The BibApp application is deployed to /bibapp/ruby/bibapp/

Ruby install notes:

  1. Get Ruby, unpack:
    * $ mkdir /bibapp/ruby
    * $ mkdir /bibapp/logs/ruby
    * $ cd /bibapp/build/source
    * $ mkdir ruby; cd ruby
    * $ wget [ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p174.tar.gz](ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p174.tar.gz)
    * $ tar xvfz ruby-1.8.7-p174.tar.gz
    * $ cd ruby-1.8.7-p174
  1. Compile, make, make install:
    * $ ./configure --prefix=/bibapp/ruby/ruby-1.8.7-p174 --enable-pthread
    * $ cd ext/openssl
    * $ ruby extconf.rb --with-openssl-dir=/usr/sfw
    * $ cd ../..
    * $ make
    * $ make test
    * $ make install
  1. Configure the Ruby environment:
    * Add RUBY\_HOME to ~bibappadm/.profile, modify the PATH:
```
         RUBY_HOME=/bibapp-qa/ruby/ruby-1.8.7-p174
         export RUBY_HOME
         PATH=$RUBY_HOME/bin:$PATH
         export PATH
```
    * $ . ~/.profile
  1. Get Ruby Enterprise Edition, unpack:
    * $ cd /bibapp/build/source/ruby
    * $ wget http://rubyforge.org/frs/download.php/64475/ruby-enterprise-1.8.7-20090928.tar.gz
    * $ tar xvfz ruby-enterprise-1.8.7-20090928.tar.gz
    * $ cd ruby-enterprise-1.8.7-20090928
  1. Install Ruby Enterprise Edition:
    * $ cd /bibapp/build/source/ruby
    * $ export CFLAGS="-I/usr/sfw/include"
    * $ ./ruby-enterprise-1.8.7-20090928/installer
    * Where would you like to install Ruby Enterprise Edition to?
      * [/opt/ruby-enterprise-1.8.7-20090928] : /bibapp-qa/ruby/ruby-enterprise-1.8.7-20090928
  1. Configure the Ruby Enterprise Edition environment, overriding the base ruby install performed earlier:
    * Edit ~/.profile:
```
         RUBY_HOME=/bibapp-qa/ruby/ruby-enterprise-1.8.7-20090928
         export RUBY_HOME
         PATH=$RUBY_HOME/bin:$PATH
         export PATH
```
    * $ unset PATH
    * $ . ~/.profile

### Apache ###

Apache 2.2.13 webserver (/bibapp/apache/apache-2.2.13)
> The Apache webserver is the semi-public face of the bibapp. as well as static HTML.
> The webserver contains the basic set of modules, plus mod\_ssl, mod\_proxy**, and mod\_rewrite.**

Apache install notes

  1. Get Apache, unpack:
    * mkdir /bibapp/apache
    * mkdir /bibapp/logs/apache
    * mkdir /bibapp/apache/content
    * cd /bibapp/build/source
    * mkdir apache/apache-2.2.13; cd apache/apache-2.2.13
    * wget http://mirror.atlanticmetro.net/apache/httpd/httpd-2.2.13.tar.gz
    * wget http://www.apache.org/dist/httpd/httpd-2.2.13.tar.gz.md5
    * md5sum httpd-2.2.13.tar.gz
    * md5sum -c httpd-2.2.13.tar.gz.md5
    * tar xvfz httpd-2.2.13.tar.gz
  1. Configure, make, make install:
    * cd /bibapp/build/source/apache/apache-2.2.13/httpd-2.2.13
    * ./configure --prefix=/bibapp/apache/apache-2.2.13 \ --with-mpm=prefork \ --enable-mods-shared=most \ --enable-proxy \ --enable-ssl \ --with-ssl=/usr/sfw
    * make
    * make install
  1. Compile and install Passenger (from gem)
    * gem install passenger --version'=2.2.2'
    * export APXS2=/bibapp/apache/apache-2.2.13/bin/apxs; passenger-install-apache2-module
  1. Set up the webserver
    * cd /bibapp/apache/apache-2.2.11
    * rm -rf manual logs man cgi-bin htdocs
    * # Set up the Apache configurations for the webserver
    * cd conf
    * mv httpd.conf bibapp.conf
    * vi bibapp.conf


---


## Same as Ubuntu ##

  1. Add passenger lines to /bibapp/apache/apache-2.2.13/conf/bibapp.conf
```
LoadModule passenger_module /opt/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.2.5/ext/apache2/mod_passenger.so
PassengerRoot /opt/ruby-enterprise/lib/ruby/gems/1.8/gems/passenger-2.2.5
PassengerRuby /opt/ruby-enterprise/bin/ruby

<VirtualHost *:80>
  ServerName localhost
  DocumentRoot /path/to/rails_projects
  RailsBaseURI /bibapp
  <Directory /path/to/rails_projects>
    AllowOverride All
    Options Indexes FollowSymLinks MultiViews
    Order allow,deny
    Allow from all
  </Directory>
  RailsEnv development
</VirtualHost>
```
    * NB. The /path/to/rails\_projects will be the path to where you create symbolic links to your bibapp/public folder. In order for Passenger to process sub-URLs correctly, this sym link has to have the same name as your sub-URL.
```
(e.g., URL      => http://mydomain.edu/bibapp
       sym link => ln -s /path/to/bibapp/public /path/to/rails_projects/bibapp)
```
    * More on this at Step 16.
  1. Install PostgreSQL or MySQL
  1. Download BibApp code
```
svn checkout http://bibapp.googlecode.com/svn/trunk/ ~/bibapp/
```
  1. Adjust permissions for attachment and logs
    * NB. Passenger implements user switching based on the owner of config/environment.rb, so ifconfig/environment.rb is owned by joe, Passenger will launch the corresponding Rails application as joe as well
  1. Configure BibApp settings in the config/ directory
  1. Install rake
```
gem list rake #see if it's there
gem install rake #if not, install it
```
  1. Install database driver gem
```
gem install postgres -- --with-pgsql-dir=/path/to/pgsql 
gem install mysql -- --with-mysql-dir=/path/to/mysql 
```
  1. Database Setup:
    1. Create bibapp user
```
createuser -dSRP bibapp
```
    1. Create bibapp database
```
createdb -U bibapp -E UNICODE bibapp_development
```
  1. Generate BibApp database structure
```
rake db:schema:load
```
  1. Create an 'admin' user, and load publishers from SHERPA/RoMEO
```
rake db:seed
```
  1. Create a symbolic link to your bibapp/public directory
```
ln -s ~/bibapp/public ~/rails_projects/bibapp
```
  1. Start BibApp (starts solr, delayed\_job, and passenger)
```
rake bibapp:start
```