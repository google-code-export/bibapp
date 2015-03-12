# BibApp and Ruby on Rails stack installation on Debian/Ubuntu #

_**Thanks Bruno!**_

```
sudo apt-get install subversion

sudo apt-get install default-jdk

sudo apt-get install apache2 apache2-prefork-dev

sudo /etc/init.d/apache2 stop

sudo usermod -d /home/apache -m www-data

sudo /etc/init.d/apache2 start

sudo apt-get install postgresql

sudo su - postgres -c 'createuser -P -d -R -S bibapp'

createdb -U bibapp -h 127.0.0.1 -W -e -E UNICODE bibapp_development

createdb -U bibapp -h 127.0.0.1 -W -e -E UNICODE bibapp_production

sudo apt-get install ruby irb rdoc

sudo apt-get install libopenssl-ruby build-essential ruby1.8-dev libpq-dev
libxml2 libxml2-dev

mkdir /tmp/ror_installation

cd /tmp/ror_installation

wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz

tar -xvzf rubygems-1.3.5.tgz

cd rubygems-1.3.5/

sudo ruby setup.rb

sudo ln -s /usr/bin/gem1.8 /usr/bin/gem

sudo gem update --system

sudo gem install rake --no-ri --no-rdoc

sudo gem install postgres --no-ri --no-rdoc

sudo gem install passenger --no-ri --no-rdoc

sudo gem install daemons --no-ri --no-rdoc

sudo gem install hoe --no-ri --no-rdoc

sudo gem install rack -v=1.0.0 --no-ri --no-rdoc

sudo gem uninstall rack -v=1.2.1

sudo rake gems:install

sudo mkdir -p /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib

cd /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib

sudo svn export http://bibapp.googlecode.com/svn/trunk/ bibapp

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/
config/database.yml.example /home/apache/vhosts/dspace/bibapp.openrepository
.com/var/lib/bibapp/config/database.yml

sudo vim /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp
/config/database.yml

development:

  adapter: postgresql

  encoding: utf8

  database: bibapp_development

  username: bibapp

  password: ...

# Warning: The database defined as 'test' will be erased and

# re-generated from your development database when you run 'rake'.

# Do not set this db to the same as development or production.

test:

  adapter: postgresql

  encoding: utf8

  database: bibapp_test

  username: bibapp

  password: ...

production:

  adapter: postgresql

  encoding: utf8

  database: bibapp_production

  username: bibapp

  password: ...

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/
config/personalize.rb.example /home/apache/vhosts/dspace/bibapp.
openrepository.com/var/lib/bibapp/config/personalize.rb

sudo vim /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp
/config/personalize.rb

$APPLICATION_URL             = "
http://ec2-67-202-4-214.compute-1.amazonaws.com/bibapp"

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/
config/solr.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com
/var/lib/bibapp/config/solr.yml

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/
config/smtp.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com
/var/lib/bibapp/config/smtp.yml

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/
config/sword.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.
com/var/lib/bibapp/config/sword.yml

sudo vim /etc/postgresql/8.4/main/pg_hba.conf

# "local" is for Unix domain socket connections only

local   all         all                               trust

# IPv4 local connections:

host    all         all         127.0.0.1/32          trust

# IPv6 local connections:

host    all         all         ::1/128               md5

sudo /etc/init.d/postgresql restart

cd /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp

sudo rake gems:install

sudo rake db:schema:load RAILS_ENV=development

sudo rake solr:start

sudo rake db:seed RAILS_ENV=development

sudo rake solr:stop

sudo passenger-install-apache2-module

sudo vim /etc/apache2/mods-available/passenger.load

LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-3.0.0/ext/
apache2/mod_passenger.so

sudo vim /etc/apache2/mods-available/passenger.conf

PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-3.0.0

PassengerRuby /usr/bin/ruby1.8

sudo mkdir -p /home/apache/vhosts/dspace/bibapp.openrepository.com/htdocs/

sudo ln -s /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/
bibapp/public/home/apache/vhosts/dspace/bibapp.openrepository.com/htdocs/
bibapp

sudo vim /etc/apache2/sites-available/bibapp.openrepository.com

<VirtualHost *:80>

        ServerAdmin webmaster@localhost

        DocumentRoot /home/apache/vhosts/dspace/bibapp.openrepository.com/htdocs

        RailsEnv development

        RailsBaseURI /bibapp

        <Location /bibapp>

                Options Indexes +ExecCGI FollowSymLinks

                Order allow,deny

                Allow from all

        </Location>

        ErrorLog /var/log/apache2/error.log

        # Possible values include: debug, info, notice, warn, error, crit,

        # alert, emerg.

        LogLevel warn

        CustomLog /var/log/apache2/access.log combined

</VirtualHost>

sudo chown www-data.www-data -R /home/apache/

sudo a2enmod passenger

sudo a2ensite bibapp.openrepository.com

sudo apache2ctl graceful

sudo rake bibapp:start 
```

# Old instructions (_deprecated_) #
```
sudo apt-get install subversion

sudo apt-get install default-jdk

sudo apt-get install apache2 apache2-prefork-dev 
sudo /etc/init.d/apache2 stop
sudo usermod -d /home/apache -m www-data
sudo /etc/init.d/apache2 start

sudo apt-get install postgresql
sudo su - postgres -c 'createuser -P -d -R -S bibapp' 
createdb -U bibapp -h 127.0.0.1 -W -e -E UNICODE bibapp_development
createdb -U bibapp -h 127.0.0.1 -W -e -E UNICODE bibapp_production

sudo apt-get install ruby irb rdoc
sudo apt-get install libopenssl-ruby build-essential ruby1.8-dev libpq-dev libxml2 libxml2-dev

mkdir /tmp/ror_installation
cd /tmp/ror_installation
wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz
tar -xvzf rubygems-1.3.5.tgz

cd rubygems-1.3.5/
sudo ruby setup.rb
sudo ln -s /usr/bin/gem1.8 /usr/bin/gem

sudo gem update –system
sudo gem install rake --no-ri --no-rdoc
sudo gem install postgres --no-ri --no-rdoc
sudo gem install passenger --no-ri –no-rdoc
sudo gem install daemons --no-ri –no-rdoc
sudo gem install rack -v=1.0.0 --no-ri –no-rdoc
sudo gem uninstall rack -v=1.1.0
sudo rake gems:install

sudo mkdir -p /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib
cd /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib
sudo svn export http://bibapp.googlecode.com/svn/trunk/ bibapp
sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/database.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/database.yml

sudo vim /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/database.yml

development: 
  adapter: postgresql 
  encoding: utf8 
  database: bibapp_development 
  username: bibapp 
  password: ...

# Warning: The database defined as 'test' will be erased and 
# re-generated from your development database when you run 'rake'. 
# Do not set this db to the same as development or production. 
test: 
  adapter: postgresql 
  encoding: utf8 
  database: bibapp_test 
  username: bibapp 
  password: ...

production: 
  adapter: postgresql 
  encoding: utf8 
  database: bibapp_production 
  username: bibapp 
  password: ...

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/personalize.rb.example /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/personalize.rb

sudo vim /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/personalize.rb

$APPLICATION_URL             = "http://ec2-67-202-4-214.compute-1.amazonaws.com/bibapp"

sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/solr.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/solr.yml
sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/smtp.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/smtp.yml
sudo cp /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/sword.yml.example /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp/config/sword.yml

sudo vim /etc/postgresql/8.4/main/pg_hba.conf

# "local" is for Unix domain socket connections only 
local   all         all                               trust 
# IPv4 local connections: 
host    all         all         127.0.0.1/32          trust 
# IPv6 local connections: 
host    all         all         ::1/128               md5

sudo /etc/init.d/postgresql-8.3 restart 

cd /home/apache/vhosts/dspace/bibapp.openrepository.com/var/lib/bibapp

sudo rake gems:install
sudo rake db:schema:load RAILS_ENV=development
sudo rake solr:start
sudo rake db:seed RAILS_ENV=development
sudo rake solr:stop
sudo passenger-install-apache2-module

sudo vim /etc/apache2/mods-available/passenger.load

LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.2.9/ext/apache2/mod_passenger.so 

sudo vim /etc/apache2/mods-available/passenger.conf
PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.2.9 
PassengerRuby /usr/bin/ruby1.8

sudo mkdir -p /home/apache/vhosts/bibapp.openrepository.com/htdocs/
sudo ln -s /home/apache/vhosts/bibapp.openrepository.com/var/lib/bibapp/public /home/apache/vhosts/bibapp.openrepository.com/htdocs/bibapp

sudo vim /etc/apache2/sites-available/bibapp.openrepository.com

<VirtualHost *:80> 
        ServerAdmin webmaster@localhost 

        DocumentRoot /home/apache/vhosts/bibapp.openrepository.com/htdocs 

        RailsEnv development 
        RailsBaseURI /bibapp 

        <Location /bibapp> 
                Options Indexes +ExecCGI FollowSymLinks 
                Order allow,deny 
                Allow from all 
        </Location> 

        ErrorLog /var/log/apache2/error.log 
 
        # Possible values include: debug, info, notice, warn, error, crit, 
        # alert, emerg. 
        LogLevel warn 

        CustomLog /var/log/apache2/access.log combined 

</VirtualHost> 

sudo a2enmod passenger
sudo apache2ctl graceful
sudo rake bibapp:start

```


# BibApp and Ruby on Rails stack installation on Ubuntu Linux (old) #

## Additional Pre-requisites for Ubuntu / Debian ##

Before trying an installation on Ubuntu or Debian-based operating systems, there are a couple of libraries you'll want to make sure you have installed:
  * `libxml2` and `libxml2-dev`
  * Latest Ruby Development package (e.g. `ruby1.8-dev`)

In addition, if you are planning to install BibApp on MySQL, you will need to MySQL development package.  This is unnecessary if you will be using PostgreSQL.
  * `libmysqlclient-dev`

You should be able to install these packages quickly via `apt-get`.  For example:
```
  sudo apt-get install libxml2 libxml2-dev ruby1.8-dev
```


## BibApp and Rails stack on Ubuntu ##
  1. Install RubyEE
    1. Download the .deb package: http://www.rubyenterpriseedition.com/download.html
    1. Install the deb: sudo dpkg -i path/to/deb/file
    1. Add /opt/ruby-enterprise/bin to PATH in /etc/environment
    1. Create sym links to RubyEE executables
```
ln -s /opt/ruby-enterprise/bin/ruby /usr/bin/ruby
ln -s /opt/ruby-enterprise/bin/gem /usr/bin/gem
ln -s /opt/ruby-enterprise/bin/ri /usr/bin/ri
ln -s /opt/ruby-enterprise/bin/rdoc /usr/bin/rdoc
ln -s /opt/ruby-enterprise/bin/irb /usr/bin/irb
```
    1. Ubuntu sudo is set to a secure path, so you need to tell it where rake is
```
sudo ln -s `which rake` /usr/local/bin/
```
  1. Install Apache 2
```
sudo apt-get apache2
```
  1. Install Apache 2 development headers:
```
sudo apt-get install apache2-prefork-dev 
```
  1. Install Apache Portable Runtime (APR) development headers:
```
sudo apt-get install libapr1-dev 
```
  1. Install Apache Portable Runtime Utility (APU) development headers:
```
sudo apt-get install libaprutil1-dev
```
  1. Install Phusion Passenger
    1. Get the gem
```
sudo gem install passenger
```
    1. Install and follow the instructions
```
sudo /opt/ruby-enterprise/bin/passenger-install-apache2-module
```
  1. Add these lines to /etc/apache2/apache2.conf
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
    * More on this at Step 17.
  1. Install PostgreSQL
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