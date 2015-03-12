# Introduction #

This page serves as a guide for developers working with BibApp's SVN to update or modify code, gems or plugins.

# Gem Management #

All required Gems to run BibApp are managed in the `/config/environment.rb` as [Gem Dependencies](http://railscasts.com/episodes/110) (a new feature of Rails as of version 2.1).  The only exception are gems which are created specifically for BibApp, or are too "young" in their development cycle for Gem Dependencies to work.

To upgrade a version of a Gem, you need only update the dependency listed in `/config/environment.rb`.  For example, to update Hpricot to _minimally require_ version 0.6 instead of 0.5, you'd change the following:
```
config.gem "hpricot", :version=>"~>0.5", :source=>"http://code.whytheluckystiff.net"
```
To this:
```
config.gem "hpricot", :version=>"~>0.6", :source=>"http://code.whytheluckystiff.net"
```
Notice the change from `~>0.5` to `~>0.6`.

**REMEMBER**: after changing a gem version within `environment.rb`, you need to run `rake gems:install` to install that new gem version!

## Gem Management Tips ##

  1. **Versions:** Here's a quick guide of how versions are handled within `environment.rb`:
    * `"0.5"` -- require version 0.5 _exactly_
    * `">=0.5"` -- require version 0.5 or greater
    * `"~>0.5"` -- require version 0.5 or greater, but don't allow next major version (1.0).
  1. **Plugin or Rake task dependencies:**  If you have plugins or rake tasks that `require` particular gems, you may see errors when you run `rake gems:install`, as rake attempts to initialize all plugins and rake tasks.   When this happens, replace your simple `require 'solr-ruby'` statement with: `require 'solr-ruby' if defined? Solr`
    * This tip was found at: http://www.webficient.com/2008/7/11/rails-gem-dependencies-and-plugin-errors

# Plugin Management #

All necessary plugins are "frozen" in /vendor/plugins.

We are slowly moving towards using [Piston](http://piston.rubyforge.org/) to help with plugin management, as Piston makes it easier to upgrade existing plugins.

It is recommended that new plugins be added via Piston.  For example:
```
piston import http://svn.hamptoncatlin.com/make_resourceful/trunk/ make_resourceful
svn commit -m "Piston: Adding make_resourceful plugin usin Piston"
```

However, it's worth noting a major limitation of Piston at this time:
  * Piston currently only works if the plugin source code is being stored in SVN.  This is a big limitation as many plugin makers now use Git.  However, Piston 2.0 is in the works and is planning to fix this limitation.