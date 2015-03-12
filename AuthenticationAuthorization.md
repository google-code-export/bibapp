## I. Authentication ##

### Goals ###
  * Preferable to use an existing Rails plugin
  * Cannot assume any particular local authentication mechanism - Configurable & Extendable!
  * Out-of-the-box, BibApp should minimally support basic HTTP authentication (with an encrypted password in the database).  Should be easily extendable/configurable to support other authentication mechanisms.

### Plugin Recommendations ###

  * **Authentication Plugin Analysis**
    1. [Simple HTTP Auth](http://agilewebdevelopment.com/plugins/simple_http_auth)  plugin?
      * Advantages:
        * Doesn't force you into an authentication method.  You are responsible for writing your own manner of authenticating - Dynamic!
        * Doesn't force you into using a particular model, controller, etc.
      * Disadvantages:
        * A little more work for us.  It also doesn't maintain your user database or anything.  We'd need to develop a few example authentication methods (e.g. simple HTTP, Active Directory/LDAP, OpenID, etc.) which could be selected from when setting up BibApp.
        * **Does not seem to play well with 'authorization' plugin!**  This 'Simple HTTP Auth' plugin is expecting you to specify controller(s) which "requires\_authentication", and the authentication method within that same controller.  However, the 'authorization' plugin is expecting to redirect to a single controller whenever authentication is deemed necessary.  (**In simple terms:** The basic problem is that this 'Simple HTTP Auth' plugin unfortunately overlaps a little too much into _authorization_, which looks like it will make it difficult to integration with the rails `authorization` plugin.)
    1. [restful\_authentication](http://railscasts.com/episodes/67) plugin?
      * Advantages:
        * Plays well with 'authorization' plugin
        * Easy to get basic username/password authentication up and running
      * Disadvantages:
        * Not sure if this is dynamic enough to support external authentication methods (where an already authenticated username is passed to BibApp).  May require quite a bit of customization to support!
    1. [Authenticate as Remote User](http://blog.craz8.com/authenticate-as-remote-user-plugin/) plugin - _Requires More Close Analysis_
      * This plugin only assumes username is passed in a Request variable...by default looks for the Apache "REMOTE\_USER" header, but it looks to be easily configurable.  Not sure if this is dynamic enough though, as it looks to be built more for Apache-based authentication.
  * **Plugin Recommendations**
    * Admittedly, still a little up-in-the-air.  After closer analysis of the three plugins listed above, I'm now thinking that the proper approach may be to **extend** the `restful_authentication` plugin, and add-on the ability to "Authenticate as a remote user" (i.e. a mashup of plugins #2 and #3 listed above...which are already very similar).

_**To-Do:**_ Fill in more details on Authentication.  Make decision on proper plugin to use.


## II. Authorization ##

### Goals ###
  * Preferable to use an existing Rails plugin
  * Authorization "roles" will be assigned to "users"
  * Should follow a basic "sentence-like" structure: "{user} has {role} on {object}"
    * BibApp {objects} include: Groups (i.e. departments/units), Authors, and/or Citations


### Proposed BibApp Roles ###

These roles are not finalized, but have been discussed and generally agreed upon.

_Role:_ **Admin**
  * Generally can:
    * Create/Edit/Delete/Hide any object (i.e. Group/Author/Citation) within this role's "context"
    * Add/Edit/Remove roles or users from system
    * All other tasks which can be performed by a `editor`
  * Generally cannot:
    * No limitations...this user has FULL RIGHTS
_Role:_ **Editor**
  * Generally can:
    * Create/Edit/Delete/Hide any object (i.e. Group/Author/Citation) within this role's "context"
    * Assign or Remove `editor` role (in same context) to/from user accounts
    * Package up items for external repository
    * Create/Edit/Delete/Hide metadata, establish "authorities"
  * Generally cannot:
    * Remove user accounts from system **(??)**
    * Create NEW roles or user accounts **(??)**
    * Assign an `admin` role to any user
~~_Role:_ **Librarian**~~
  * _This role was determined to be unnecessary.  After further discussion it was decided that there was no signficant difference between a 'librarian' and an 'editor.'_
~~_Role:_ **Author**~~
  * Can only add, edit or remove data about an author. _This role looks to be unnecessary, as it seems to be an "editor" role on an "author" object._  However, if we determine there **is** a difference, we can add this role back in later.

~~_Role:_ **Public**~~
  * General public role.  Just has rights to view, search, browse data in the system.  _**This role is unnecessary**, as it is just the absence of any of the above roles._


**_Example Role Assignments:_**
  * Remember, authorization should follow a basic "sentence-like" structure: "{user} has {role} on {object}"
    * "Eric" has "Admin" role on BibApp (_Application-based role_)
    * "Tim" has "Librarian" role on group "University Library" (_Group-based role_)
    * "Matt" has "Editor" role on author "Matt Cordial" (_Author-based role_)
    * "Ben" has "Editor" role on citation #2345 (_Citation-based role_)
  * _Note:_ It will likely not be common to assign roles to individual citations (see last example above).  But, the BibApp authorization system should still support it, as it is just another {object} within BibApp.
  * Roles should cascade!  So, if you are an "Editor" on a group, you are also an "Editor" on all authors within that group, and all citations of those authors.


### Plugin Recommendations ###

  * Use "[Authorization plugin](http://www.writertopia.com/developers/authorization)", which seems to provide very clean [role-based authorization using dynamic methods](http://www.rubyinside.com/authorization-permissions-plugin-for-rails-154.html).  Also seems to be highly recommended/respected (e.g. [Authorization in Rails](http://www.vaporbase.com/postings/Authorization_in_Rails)).

#### Limitations of Plugin ####

  * Out-of-the-box, it does NOT come with any ability to cascade or inherit roles.  So, this plugin doesn't know that an "admin" role also encompasses all the tasks that a "librarian" can perform.  This makes sense, since this plugin cannot "understand" what a role means.
  * In the same manner, it doesn't understand that a role on a "Group" cascades down to "Authors" within that group.  Again, it doesn't attempt to figure out how roles should cascade for you...you have to do that yourself.
  * There are three "types" of roles supported by this plugin:
    1. Generic roles:  (e.g.) "admin".
      * Just says you are an 'admin', but doesn't really say over WHAT
    1. Class roles: (e.g.) "admin of Group"
      * Says you have an 'admin' role over the Group class
    1. Object instance roles: (e.g.) "admin of group called 'University Library'"
      * Says you are an 'admin' of the 'University Library' group only (and no other group instances)
  * There is also no inheritance/cascading of these role "types".  So, if you are an "admin", this does NOT cascade so that you are also an "admin of Group" (or any other Class or object).  Similarly, if you are an "admin of Group", it does NOT give you 'admin' permissions over specific group instances, like a group called 'University Library'.
  * For BibApp 1.0, we will be mostly using "Object instance roles", as they provide roles on specific objects in the system.  There will be a few exceptions where "Class roles" are necessary (see BibAppAuthDemo below).  But, we should avoid assigning "Generic roles", since these do not assign a role to an object (and also do not cascade).

Admittedly, this lack of cascading/inheritance is a little confusing at first.  But, luckily it is relatively easy to override so that we can get the cascading/inheritance we desire in BibApp.

### BibAppAuthDemo ###

To better prototype out our Authorization for BibApp, I've created the BibAppAuthDemo prototype project.  This same project will eventually be used to prototype out Authentication options, and get them working in conjunction with Authorization.

Here's a few notes to get you started with this prototype:
  * First, [download BibAppAuthDemo](http://groups.google.com/group/bibapp/web/BibAppAuthDemo.zip) and install it locally.  Make sure to modify the `config/database.yml` for your setup!
  * Run `rake db:migrate` of course, to generate the database and some basic test data.
  * Startup Mongrel, and visit: http://localhost:3000/users/list
  * From here, you'll see some test data.  To "login" as a particular user (and get his/her role(s) in the system), just click "Make Current User" next to that user.  _There is NO login functionality here yet, since this is currently just a prototype of authorization!_
  * None of this is really "fancy".  It's mostly just scaffolding, and some overriding of the "Authorization Plugin" to allow for cascading/inheriting of roles in BibApp (see below for more details)
  * Feel free to change, add, remove data, roles, users, etc.  Everything should work! (But, obviously there may be some unnoticed bugs, as this is just a prototype).

#### Semi-Technical Notes on BibAppAuthDemo ####

  * Despite all the limitations of the "Authorization Plugin" mentioned above, I was able to override default actions of the plugin so that it can better understand and support the inheritance/cascading of roles that we desire for BibApp.   This overriding takes place in the _User_ model, specifically look for these methods:
```
   #Override has_role? to support cascading roles based on the
   # role hierarchy defined for BibApp
   #
   # Returns if user has a specified role.
   def has_role?( role_name, authorizable_obj = nil )

     #Lots of code which overrides the default settings of Authorization plugin
     
   end

   #Checks to see if user has a specified role on ANY instance
   #of the passed in Class.
   #
   # (e.g.) has_any_role?('editor', Group) 
   #
   # The above would check if the user has the 'editor' role
   # on ANY group within the system.
   def has_any_role?( role_name, authorizable_class )

     #A custom method, based on the Authorization plugin
     
   end
		
```
  * The 'BibAppAuthDemo' uses 3 Classes of objects which can have authorization roles set on them: `System`, `Group`, and `Author` models
    * For simplicity, I didn't get into Citations, but it will be easily implemented similar to the `Group` -> `Author` relationship
  * The `System` Class is a special Model which is NOT stored in the Database (I'm using the [ActiveRecord::Base Without Tables](http://agilewebdevelopment.com/plugins/activerecord_base_without_table) plugin to do this). It's whole purpose is to give us a place to assign global/system-wide roles.  So, if a user is given an "admin on System" role, I've set it up so that he/she is an 'admin' on EVERYTHING in BibApp.  Similarly, if you are an 'editor on System', you are an 'editor' on EVERYTHING.
    * _This is an example where we are using a "Class-based" role (with the `System` class) instead of an "Object-instance role"._
  * Group-based roles are setup to cascade down to authors within that group!  So, if you are a 'librarian' on a group named "University Library", you are also a 'librarian' on EVERY author who is a member of that group.   This concept could be replicated to allow Author-based roles to cascade down to their Citations in a similar fashion.
  * A few points which may or may not be entirely straightforward:
    * In BibAppAuthDemo, roles cascade _as-is_.  This means if you are an "editor" on a group named 'University Library', then you are ONLY given "editor" permissions on all the authors in that group.  You are NOT given "admin" or "librarian" permissions on those authors.
    * Because of this cascading, you only need to specify the MINIMAL role necessary to perform an action.  This is nice, since it shortens "permit" statements (a part of Authorization plugin).  For example, if it's an action you need a minimum of 'editor' permissions to perform, you can just specify:
```
permit 'editor' do
   #action can be performed by editor, librarian, or admin
end
```
    * Normally, you would need to provide a large OR of all possible roles:
```
permit 'editor' or 'librarian' or 'admin' do
   #action can be performed by editor, librarian, or admin
end
```
    * Take a look at the variety of samples within the 'Group' and 'Author' Controllers.  There's also a 'Test' controller with even more examples of these simple 'permit' statements.

#### How Roles Cascade ####

Here's some example roles in BibAppAuthDemo, and details of what permissions you automatically inherit in those roles. Again, these are _not final_, but just how I implemented them in BibAppAuthDemo.  I wanted to make very explicit how I chose to cascade roles, so that we can determine if there are better ways to support cascading roles in BibApp 1.0:

  * `admin` role on BibApp `System`
    * Role has full access on EVERYTHING in BibAppAuthDemo.  This user can do anything...no limitations!
  * `editor` role on BibApp `System`
    * Role has 'editor' access on EVERYTHING in BibAppAuthDemo.  However, that means this role is not permitted to perform **any** actions specifically marked with 'librarian' or 'admin'.
    * Role has access to create, edit, delete Groups or Authors in system. (Although not enforced in this prototype, I'd envision this role could NOT create/edit/delete new Users or Roles in system)
  * `librarian` role on group named 'University Library'
    * Role inherits `librarian` permissions on every Author in that group.  Would also inherit `librarian` permissions on every Citation of every Author in that group (if I had implemented citations in BibAppAuthDemo).
    * Role also has the permissions to create new Authors to add to this group, or remove authors from this group.
    * As implemented, it currently does _NOT_ allow for creation of new Groups (since this role is specific to a _single group_).  It also does _NOT_ allow for deletion of this specific Group. **(This is something worth discussing in more detail)**
  * `editor` role on author named "Timothy G Donohue"
    * Role inherits `editor` permissions on every Citation of this author.
    * As such, this role would permit user to add/edit/remove citations from this author (if I had implemented citations in BibAppAuthDemo)
    * As implemented, it does _NOT_ allow for creation of new Authors (since this role is specific to a _single author_).  Currently it also does _NOT_ allow for deletion of this Author either. (I'd envision there would be a "suppress" option available, where this `editor` could actually suppress this Author so that the Author page was not viewable/searchable). **(This is something worth discussing in more detail)**
    * _Note:_ This is the role I currently envision would be assigned to users when they click "This is Me" on an author page in BibApp.  This would allow them to manage their Author information, and add/edit/remove their citations into the system. **(Worth discussing: Should this role also be allowed to assign additional Users the `editor` role on this same author? - i.e. give others the ability to edit their author info)**