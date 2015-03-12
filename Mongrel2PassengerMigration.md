Steps for migrating BibApp from Mongrel clusters to Phusion Passenger (mod\_rails). Passenger deploys Rails applications using the the industry standard [Apache web server](http://httpd.apache.org/) or the fast and lightweight [Nginx web server](http://www.nginx.net/). One of these must be installed first (we use Apache).

# Passenger Installation #
  1. Install via the gem:
```
    gem install passenger
    passenger-install-apache2-module
```
  1. Following the instructions from the installer, edit your Apache config file, and add these lines:
```
    LoadModule passenger_module /path/to/ruby/gems/passenger-x.x.x/ext/apache2/mod_passenger.so
    PassengerRoot /path/to/ruby/gems/passenger-x.x.x
    PassengerRuby /usr/bin/rubyx.x
```
  1. Add a virtual host for your BibApp in your Apache config file:
```
    <VirtualHost *:80>
      ServerName localhost
      DocumentRoot /path/to/bibapp/public
    </VirtualHost>
```
> > NB. Make sure you point `DocumentRoot` to your BibApp's _public_ directory.
  1. To deploy BibApp to a sub URL (_e.g._, `http://www.example.edu/bibapp/`):
> > a. Create a directory for rails websites
> > > `mkdir /rails/websites`

> > b. Create a symbolic link to your BibApp's _public_ folder in your `websites` directory.
> > > `ln -s /path/to/bibapp/public /rails/websites/bibapp`

> > c. Edit the virtual host for your BibApp in your Apache config file:
```
      <VirtualHost *:80>
        ServerName localhost
        DocumentRoot /rails/websites
        RailsBaseURI /bibapp
        <Directory /rails/websites>
          AllowOverride All
          Options Indexes FollowSymLinks MultiViews
          Order allow,deny
          Allow from all
        </Directory>
        RailsEnv development
      </VirtualHost>
```
> > > NB. Make sure `DocumentRoot` points to your websites directory (that contains the sym link to `bibapp/public`), and that `RailsBaseURI` is the name of the sub URI. You can deploy multiple Rails applications under a virtual host, by specifying `RailsBaseURI` multiple times.
  1. Remove the `.htaccess` file from your `bibapp/public` directory. It was needed by Mongrel, but will cause problems for Passenger.

> > <br />
  1. Change the owner of your BibApp to a restricted user (_e.g._, the _apache_ user).
> > IMPORTANT: Passenger will run BibApp as the owner of the file `config/environment.rb`. So, the owner of `environment.rb` must have read access to all the application's files. In addition, the user must have read/write access to `log/`, `tmp`, and `public/attachments`, along with their sub-directories.
> > Under no circumstances will BibApp be run as _root_. If `environment.rb` is owned by _root_ or by an unknown user, then Passenger will launch BibApp as the _nobody_ user.

# Links #
[Passenger User's Guide](http://www.modrails.com/documentation/Users%20guide.html)