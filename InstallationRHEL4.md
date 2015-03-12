**_Table of Contents:_**


## Installation Procedure ##

| This procedure details how to install and configure all software required to be managed by the BibApp Service Manager. The installation instructions should be followed in the order they are displayed below. |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

**Installation Notes:**

  * `$HOME` - refers to the home directory of the _bibapp-user_ user
  * **All** installations are done as the _bibapp-user_ user (`su - bibapp-user`)

### I. Service User Environment Initialization ###

#### A. Initialize User Environment ####

| This section assumes that the _bibapp-user_ is using [TSCH](http://www.tcsh.org/tcsh.html/top.html) (T-Shell). It will require modification if you ever decide to switch the _bibapp-user_ user's shell. |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

  * Become the _bibapp-user_.
    * `su - bibapp-user`
  * Edit/Create a `~/.forward` file for the _ideals-dsoace_ user. Emails which would have been sent to the _bibapp-user_ will instead be forwarded to the email address(es) listed in the file.
  * Create a `$HOME/tmp` directory, which can be used for temporary uploads to this server. Give write permissions to **only** those users in the _bibapp-user_ group (this group should only include users who are able to `su` to the service user account):
    * `mkdir $HOME/tmp`
    * `chmod 775 $HOME/tmp`
  * Edit/Create a `$HOME/.tcshrc` file for the _bibapp-user_ user. We'll be adding more environment variables later...for now, we're just creating initial `.tcshrc` settings:
```
 #Setup XTerm window title & prompt to be of form:
 # user@servername:~>
 if(! ${?TERM}) setenv TERM ""
 switch ($TERM)
         case "xterm*":
                 set prompt="%{\033]0;%n@%m:%~\007%}%n@%m:%~%# "
                 breaksw
         default:
                 set prompt="%n@%m:%~%# "
                 breaksw
 endsw
 #Default newly created files to 644 and directories to 755           
 umask 022
 #Aliases to display colors when listing files
 alias ls        'ls --color'
 alias la        'ls -al --color'
 alias ll        'ls -lav --color'
 alias lt        'ls -lavt --color'
 #Add sbin directories to PATH (they aren't there by default)
 setenv PATH /usr/sbin:/sbin:$PATH
 #Add _bibapp_user_'s 'bin' directory to PATH
 setenv PATH $HOME/bin:$PATH 
```


#### B. Enable Remote Login via SCP, SFTP, Rsync etc. ####

| Although this step is optional, it is highly recommended as it will allow you to more easily copy local files to/from the _bibapp-user_'s home directory via either SCP, SFTP, rsync or similar. |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

  * **Prerequisite:** If you are running Windows on your local machine, you should install [Cygwin](http://www.cygwin.com) or [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/) for easier access to Linux command line tools such as SSH, SCP and SFTP. It's recommended to install Cygwin, and then install [puttycyg](http://code.google.com/p/puttycyg/), which is an improved terminal emulator for Cygwin (Cygwin normally just uses the default Windows command line, which is not as nice or easy to use).
  * Generate an SSH Key on your **local machine** from Cygwin or Linux terminal:
    * `ssh-keygen -t rsa`
    * Remember where you save the key!
    * You can setup a passphrase if you wish, for higher security (this passphrase will need to be entered each time you login remotely).
  * Using SCP, copy the generated `id_rsa.pub` file over to the _bibapp-user_'s `tmp/` directory on the server.
    * (e.g.) `scp ~/.ssh/id_rsa.pub [user]@[server]:/path/to/bibapp-user/tmp/`
  * Login to the server in question and change over to the _bibapp-user_
    * `su - bibapp-user`
  * Append the contents of the `id_rsa.pub` file to the end of the _bibapp-user_'s list of `authorized_keys`:
    * `cat $HOME/tmp/id_rsa.pub >> $HOME/.ssh/authorized_keys` (if the `$HOME/.ssh/` directory doesn't exist, you will need to create it)
    * `rm $HOME/tmp/id_rsa.pub`
  * Test it out. Disconnect completely from the server, and attempt to re-login from SSH directly as the _bibapp-user_:
    * `ssh bibapp-user@[server]`
      * If you entered a passphrase when generating your SSH key, you will be prompted to re-enter it.
    * You can also now use `scp` or `sftp` to securely copy files over to the server as the _bibapp-user_
    * If you are on Windows, you may also wish to install [WinSCP](http://winscp.net) to give you a graphical interface to drag & drop files for upload. When installing WinSCP, you can use your existing `id_rsa` private key to generate a corresponding PuTTY Key (using the PuTTYgen tool that comes with WinSCP)

### II. Java Installation ###

| **Installation Location:** `$HOME/java/jdk/` |
|:---------------------------------------------|

  * Download the appropriate version of the Java SE Development Kit (JDK) from http://java.sun.com/ (NOTE: You will have to download it as a "self-extracting binary", since the RPM versions require root access to install.)
  * Create a new `java` directory under `$HOME`, and move the JDK binary to that installation location:
    * `mkdir $HOME/java`
    * `mv jdk-<version>.bin $HOME/java/`
  * Make sure that executable permissions are set
    * `cd $HOME/java`
    * `chmod +x jdk-<version>.bin`
  * Run the self-extracting binary, to install the JDK into `$HOME/java/jdk<version>/`
    * `./jdk-<version>.bin`
  * After you've finished the install, you can remove the self-extracting binary
    * `rm jdk-<version>.bin`
  * Finally, create a symbolic link so that we can reference Java from `$HOME/java/jdk/` rather than using the full version number.
    * `ln -s jdk<version> jdk`

### III. Update `PATH` for Service User ###

  * Modify the existing `$HOME/.tcshrc` file for the _bibapp-user_ user. Add the following environment variables at the end of the file:
```
 #Base path of JAVA JDK and JRE 
 setenv JAVA_HOME $HOME/java/jdk 
 setenv JRE_HOME $JAVA_HOME/jre
 #Add Java 'bin' directories to PATH 
 setenv PATH $JRE_HOME/bin:$JAVA_HOME/bin:$PATH 
```


### IV. PostgreSQL Setup & Configuration ###

| These instructions only cover how to configure the PostgreSQL 8.2.14 installation. |
|:-----------------------------------------------------------------------------------|

#### A. PostgreSQL Initialization ####

| **Database Location:** `$HOME/pgsql/databases` **Logs Location:** `$HOME/pgsql/log` |
|:------------------------------------------------------------------------------------|

  * Create a new `pgsql` directory for storing all PostgreSQL data
    * `mkdir $HOME/pgsql`
  * Create a `log` directory under `pgsql` for PostgreSQL logs
    * `mkdir $HOME/pgsql/log`
  * Add the following PostgreSQL enviroment variables to the _bibapp-user_'s `~/.tcshrc` script (you may have to source the file for these changes to take effect):
```
 #Add Environment Variables for PostgreSQL
 setenv PGDATA $HOME/pgsql/databases
 setenv PGHOST $HOME/pgsql/run 
```
  * If it doesn't already exist, create the directory you specified in the `PGHOST` environment variable:
    * `mkdir $HOME/pgsql/run`
  * Initialize the database and create the initial database structure under `$HOME/pgsql/databases` (location is controlled by `$PGDATA` environment variable)
    * `initdb`

#### B. PostgreSQL Configuration ####

  * Modify the `$HOME/pgsql/databases/postgresql.conf` configuration file as follows. You should specify each of these variables as specified below (including uncommenting them, if they are commented out by default!).
    1. `listen_addresses = 'localhost'`
      * Only allow TCP/IP connections to this database from the server itself.
    1. `port = 5432`
      * Listen for TCP/IP connection requests on port 5432
    1. `max_connections = 200`
      * Allow 200 simultaneous connections to the database. We **should** be fine with this setting.
    1. `superuser_reserved_connections = 3`
      * Reserve 3 of our connections for Superusers ONLY. One of these is specifically for the PostgreSQL `autovacuum` process.
    1. `unix_socket_directory = /path/to/bibapp-user/pgsql/run`
      * Specifies the directory where we will listen for local Unix domain socket connections. This should be set to the full path of `$PGHOST` environment variable. (You can find that full path by running: `echo $PGHOST`) _This directory must exist for the Unix domain sockets to function!_
    1. `unix_socket_permissions = 0770`
      * Specifies that only the _bibapp-user_ and group can connect via Unix domain socket.
    1. `shared_buffers = 24MB` (_default value_)
      * Recommended setting for Production systems (as specified in PostgreSQL Installation Documentation). _It should always be at least 16KB times the `max_connections` setting._ PostgreSQL recommends several tens of megabytes for Production systems. If you ever need to increase this to over 32MB of memory, you may need to increase the Linux [kernel's SHMMAX parameter](http://www.postgresql.org/docs/8.2/interactive/kernel-resources.html#SYSVIPC), which defaults to 32MB.
    1. `max_fsm_pages = 153600` (_default value_)
      * If, during vacuuming of larger tables/databases, you receive errors saying "number of page slots needed exceeds max\_fsm\_pages", then you may wish to increase this value. However, the default should be high enough for Production level systems.
    1. `redirect_stderr = on` (_default value_)
      * Instead of writing errors to `stderr` (where PostgreSQL writes errors to by default), redirect them to a log file.
    1. `log_directory = '../log'`
      * Log to the `$HOME/pgsql/log` directory. Path is relative to the `$PGDATA` environment variable.
    1. `log_filename = 'postgresql-%d.log'`
      * Log to a file named `postgresql-[day-of-month].log`, where `[day-of-month]` is "1", "2", "3", etc.
    1. `log_truncate_on_rotation = on` (_default value_)
      * Tell PostgreSQL to truncate (i.e. overwrite) existing log files of the same name. This ensures we are _only_ keeping the logs from the last month.
    1. `log_rotation_age = 1d` (_default value_)
      * Rotate the logs each day. This attempts to keep the log contents consistent with the name (so activities in `postgresql-3.log` took place on third of month, etc.)
    1. `log_rotation_size = 0` (_default value_)
      * Disable rotation of the logs based on the size of the log file.
    1. `log_min_messages = info`
      * Logs all messages that are "INFO" level or higher. INFO messages provide information implicitly requested by the user, e.g., during `VACUUM VERBOSE`
    1. `log_error_verbosity = verbose`
      * When errors occur, give a verbose error message.
    1. `log_min_error_statement = error`
      * If an error occurs, log the SQL Statement that caused the error.
    1. `log_min_duration_statement = 2000`
      * If any SQL statement takes longer than 2 seconds (2000 milliseconds) to complete, log it!
    1. `log_connections = on`
      * Log all connections to PostgreSQL (_If this begins to get out-of-hand, we may want to disable at a later time_)
    1. `log_disconnections = on`
      * Log all disconnections from PostgreSQL (_If this begins to get out-of-hand, we may want to disable at a later time_)
    1. `log_line_prefix ='<%m> [%p] '`
      * Prefix every line in the log file with '`<timestamp> [pid] `'. This ensures that we have a full timestamp (including milliseconds) and the process-id, if we notice strange errors or problems in the PostgreSQL logs.
    1. `stats_start_collector = on`
      * We want the database stats collector to be enabled, as it is necessary for the PostgreSQL `autovacuum` process.
    1. `stats_row_level = on`
      * Turn on row level database statistics, as it is necessary for the PostgreSQL `autovacuum` process.
    1. `autovacuum = on`
      * Enable the PostgreSQL `autovacuum` process. It will startup when PostgreSQL starts, and do vacuuming of databases in the background.

#### C. Create PostgreSQL "Quick" Scripts ####

In order to make it easier to start/stop PostgreSQL quickly, lets create a few basic "quick" scripts:

  * Move to the 'bin' directory, where we store all custom user scripts
    * `cd $HOME/bin`
  * Create a `start-postgres` script with the following single-line of content: | `/usr/bin/pg_ctl -D $HOME/pgsql/databases start` |
|:-------------------------------------------------|
  * Create a `stop-postgres` script with the following single-line of content: | `/usr/bin/pg_ctl stop -m fast -D $HOME/pgsql/databases` |
  * Make the scripts executable:
    * `chmod +x $HOME/bin/*postgres`

Now you should be able to use `start-postgres` and `stop-postgres` to start and stop PostgreSQL manually!

### V. Ruby Enterprise Edition Setup & Configuration ###

#### A. Pre Installation ####

An initial Ruby interpreter needs to be installed in order to use the REE installer. Also needed are:

  * C/C++ compiler
  * The 'make' tool
  * Zlib development headers
  * OpenSSL development headers
  * GNU Readline development headers
  * PostgreSQL development headers (postgresql-devel-8.2.14-1PGDG.rhel4.x86\_64.rpm)
  * Apache 2 development headers
  * Subversion (needed later for installing BibApp from trunk)
  * libxml2 and libxml2-devel

#### B. REE Initialization ####

| **Installation Location:** `$HOME/ruby/` |
|:-----------------------------------------|

  * Download the appropriate version of RubyEE from http://www.rubyenterpriseedition.com/download.html to `$HOME/tmp`
    * `cd $HOME/tmp`
    * (e.g.) `wget http://[path-to-download]/ruby-enterprise-<version>.tar.gz`
  * Extract the tarball to this directory to create `~/tmp/ruby-enterprise-X.X.X.tar.gz`
    * `tar xzvf ruby-enterprise-X.X.X.tar.gz`
  * Run the installer, and follow the instructions
    * (e.g.) `./ruby-enterprise-X.X.X/installer`
  * When the installer asks where to install, enter `/path/to/bibapp-user/ruby`
  * Add the following Ruby enviroment variables to the _bibapp-user_'s `~/.tcshrc` script:
```
 #Add Ruby 'bin' directory to PATH
 setenv RUBY_HOME $HOME/ruby
 setenv PATH $RUBY_HOME/bin:$PATH
```

#### C. Phusion Passenger Initialization ####

  * Install the Passenger gem and Apache module
    * `gem install passenger`
    * `passenger-install-apache2-module`
  * And follow the instructions
  * At the end, the installer will give you three lines that need to be included in your Apache configuration file. Copy these lines.
```
 LoadModule passenger_module /path/to/bibapp-user/ruby/lib/ruby/gems/1.8/gems/passenger-<version>/ext/apache2/mod_passeng er.so
 PassengerRoot /path/to/bibapp-user/ruby/lib/ruby/gems/1.8/gems/passenger-<version>   
 PassengerRuby /path/to/bibapp-user/ruby/bin/ruby
```
  * Edit your Apache configuration file to include the three lines above, plus this virtual host:
```
 <VirtualHost *:80>
  ServerName localhost
  DocumentRoot /path/to/bibapp-user/bibapp/public
 </VirtualHost>
```
  * Wait to restart Apache until you've finished installing BibApp. If you restart earlier, it will fail.

### VI. BibApp Installation and Configuration ###

#### A. BibApp Installation ####

| **Installation Location:** `$HOME/bibapp/` |
|:-------------------------------------------|

  * Check out the BibApp code from SVN
    * `svn checkout http://bibapp.googlecode.com/svn/trunk/ ~/bibapp/`
  * Now you may restart Apache, and it will accept configuration changes.

#### B. BibApp Configuration ####

| **NOTE** These configuration instructions assume you'll be running a production system. For development, swap every occurance of `production` with `development`, including database names (e.g., `bibapp_development`). |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

  * Edit the configurations for your local settings. In the `~bibapp/config` directory, look for the following "example" configurations: **database.yml.example** ldap.yml.example **personalize.rb.example** smtp.yaml.example **solr.yml.example** sword.yml.example
  * Copy each of these files into a file without the .example extension and personalize the contents as necessary.
  * `database.yml` (using PostgreSQL)
```
 production:
   adapter: postgresql
   encoding: utf8
   database: bibapp_production
   host: /path/to/bibapp-user/pgsql/run
   username: 
   password:  
```

  * `ldap.yml`
```
 production:
   host:                 ldap.myu.edu
   port:                 389
   base:                 dc=myu,dc=edu
   uid:                  uid
   ou:                   ou
   cn:                   cn
   givenname:            givenname
   middlename:           middlename
   sn:                   sn
   generationqualifier:  generationqualifier
   displayname:          displayname
   title:                title
   postaladdress:        postaladdress
   mail:                 mail
   telephone:            telephone

 # Active Directory users might have something like this:
   host:                 ad.myu.edu
   port:                 636
   base:                 dc=ad,dc=myu,dc=edu
   uid:                  samaccountname
   ou:                   department
   username:             CN=username,OU=Library,DC=ad,DC=uiuc,DC=edu
   password:             password
   ...
```

  * `smtp.yml`
```
 production:
   address: smtp.myu.edu
   port: 25
   domain: www.library.myu.edu
   username:
   password:
   from_email: bibapp-noreply@myu.edu 
```

  * `solr.yml`
```
 production:
   port: 8983
   stop_port: 8097 
```

  * `sword.yml`
```
 production:
   # SWORD Server's Service Document URL
   service_doc_url: https://repo.myu.edu/sword/servicedocument
   # SWORD Server default login credentials
   username: 
   password:  
   default_collection_url: https://repo.myu.edu/sword/deposit/123456789/1234
   default_collection_name: BibApp submissions via SWORD 
```

  * `personalize.yml`
```
 ####
 # Personalization Globals
 ####
 # System Administrator
 # - Will receive application error emails
 $SYSADMIN_NAME                   = "Your Name"
 $SYSADMIN_EMAIL                  = "email@myu.edu"
 # Name & base URL of your !!BibApp Application
 $APPLICATION_NAME            = "BibApp @ My U"
 $APPLICATION_URL             = "http://bibapp.myu.edu"
 $APPLICATION_TAGLINE         = "Find experts on campus... Promote their research... Archive their work"
 #Logo - place image in [bibapp]/public/images/
 $APPLICATION_LOGO            = "bibapp.png"
 # Name of your University and University URL
 $UNIVERSITY_FULL_NAME        = "University of My University"
 $UNIVERSITY_SHORT_NAME       = "MYU"
 $UNIVERSITY_URL              = "http://myu.edu"
 # Name of your University Library and Library URL
 $LIBRARY_NAME                = "University Library"
 $LIBRARY_URL                 = "http://library.myu.edu"
 # Default Address information for all people in !BibApp
 $DEFAULT_STATE               = "IL"
 $DEFAULT_CITY                = "Urbana"
 $DEFUALT_ZIP_CODE            = "61801"
 # Full Address / Contact info of Unit running !BibApp
 $UNIVERSITY_FULL_ADDRESS     = "My address"
 # Name of your local institutional repository
 $REPOSITORY_NAME = "repo"
 ####
 # Linking To Publications
 #
 # The following two variables are used to
 # find an article in your library's
 # database(s) via OpenURL.
 #
 # The link created by the following variables will
 # be of the form $WORK_BASE_URL?$WORK_SUFFIX,
 # i.e. the search is done by using 'get.'
 #
 # $WORK_BASE should be the first part of the URL
 # your institution uses to search for Publications/Works
 # up to the '?.'
 #
 # $WORK_SUFFIX can be used as follows.  Any valid
 # string of URL characters can be used.  Then use the following
 # convensions for the publication itself can be used.
 #
 # Title =>                      [title]
 # Publication year =>           [year]
 # issn/isbn =>                  [issn]
 # Issue =>                      [issue]
 # Volume =>                     [vol]
 # First Page of the Publication [fst]
 #
 # Below is an example of a suffix:
 # $WORK_SUFFIX = "id=bibapp&atitle=[title]&date=[year]&issn=[issn]&issue=[issue]&volume=[vol]&spage=[fst]"
 ####
 $WORK_LINK_TEXT          = "Find It"
 $WORK_BASE_URL           = "http://openurl.library.myu.edu/######"
 $WORK_SUFFIX             = "sid=############&atitle=[title]&date=[year]&issn=[issn]&issue=[issue]&volume=[vol]&spage=[fst]"
 ####
 # Sherpa Color Explanations
 #
 # These are the out-of-the-box explanations for each of
 # the SHERPA RoMEO "color" rankings for publishers/publications.
 $SHERPA_COLORS = {
   :green    => "Can archive pre-print and post-print",
   :blue     => "Can archive post-print (ie final draft post-refereeing)",
   :yellow   => "Can archive pre-print (ie pre-refereeing)",
   :white    => "Archiving not formally supported",
   :unknown  => "Could not determine from data"
 }
 ####
 # Sherpa API URL
 #
 # Used to retrieve publisher information from the latest SHERPA API.
 $SHERPA_API_URL = "http://www.sherpa.ac.uk/romeo/api24.php?all=yes&showfunder=none"
 ####
 # !BibApp Status Explanations
 #
 # These are the out-of-the-box explanations for each of
 # the states that a work in the !BibApp system can go through.
 $WORK_STATUS = {
   1 => "Processing",
   2 => "Duplicate",
   3 => "Accepted"
 }
 ####
 # !BibApp Archival Status Explanations
 #
 # These are the out-of-the-box explanations for each of
 # the archival states associated with a work whose file(s)
 # are being preserved in a repository.
 $WORK_ARCHIVE_STATUS = {
   1 => "Not Ready, rights unknown",
   2 => "Ready for archiving",
   3 => "Repository record created, URL known"
 }
 ####
 # !BibApp Advanced Search Examples
 #
 # These are the out-of-the-box explanations for each of
 # the states that a work in the !BibApp system can go through.
 $SEARCH_EXAMPLES ={
   :keywords   => "ex. plasma confinement physics",
   :title      => "ex. Transport Phenomena",
   :authors    => "ex. Corradini, Michael",
   :groups     => "ex. Engineering Physics",
   :issn_isbn  => "ex. 0003-018X",
   :year       => "ex. 2006  to  2008"
 }
 ####
 # Display Keywords and Abstracts
 #
 # Copyright restrictions may prohibit the display of abstracts
 # and keywords. Set this value to 'false' to prevent abstracts
 # and keywords from displaying on work pages.
 $DISPLAY_ABSTRACTS_AND_KEYWORDS = true
 ####
 # Export Keywords and Abstracts
 #
 # Similar to the $DISPLAY_ABSTRACTS_AND_KEYWORDS directive above,
 # set this value to 'false' to prevent abstracts and keywords from
 # being exported via web services (xml, yml, json).
 $EXPORT_ABSTRACTS_AND_KEYWORDS = true 
```


#### C. BibApp Post-Installation Setup ####

  * Install the required gems. Run the following commands from within the `~/bibapp` directory:
  * First, make sure `rake` is installed
    * `gem list rake`
    * Check `which rake` to make sure it is in `~/ruby/`
  * If it's missing, install it
    * `gem install rake`
  * Auto-Install the BibApp gem prerequisites, using `rake`
    * `rake gems:install`
    * If you get an error about unconfigured development database, use this command this command instead:
    * `rake gems:install RAILS_ENV='production'`
  * Install the PostgreSQL gem (if not already present)
    * `gem install pg`
  * Create a BibApp database user and production database
    * `createuser -dSRP bibapp`
    * `createdb -U bibapp -E UNICODE bibapp_production`
  * Generate the BibApp database structure
    * =rake db:schema:load
  * Initialize an administrator account and seed the current RoMEO publisher data
    * `rake db:seed`