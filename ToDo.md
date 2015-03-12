**_Table of Contents:_**


# Current BibApp TODO List (25 June 2009) #

## People ##
  * New DB fields
    * displayName - full name or _pretty name_ (i.e., J. Stephen Downey)
    * UID

### Add a new person ###
  * LDAP - better integration.
    * Config file for mapping institution-specific fields
    * Get middle name from LDAP (also show middle in display name)
    * Require unique identifier (can be different depending on institution)
    * Disallow duplicates
    * Require other fields? last name? maybe just uid
    * Combine address fields (line one, line two, city, state, ...) into one address block
    * Ditto for office address
  * General Workflow
    * ~~Streamline the process so that no steps are omitted (personal info >> pen names >>  groups >> photo)~~
  * Setting pen names
    * Take away the checkboxes; instead have trashcan icon for removing
    * Combine? Add and Add suggestions - too confusing
  * Groups
    * Sort All Groups alphabetically
  * Photo
    * ~~Separate this away from Personal Info, since it can't be done until the new person has an ID~~

### Editing a person ###
  * Workflow
    * ~~Same as add user (personal info >> pen names >>  groups >> photo)~~
    * ~~Changes to personal info may generate new pen names - we need to make sure the user is aware of that~~

### Deleting a person ###
  * ~~Nothing done yet~~
  * ~~Relationships w/other objects~~
    * ~~Destroy contributorships - this needs to be a background process; it may be overlong~~
    * ~~Destroy memberships - probably quick enough~~
    * ~~Destroy pen\_names~~
    * ~~Photo - delete it or keep it?~~
    * ~~All require a solr re-index~~

## Works ##

### Adding a work ###
  * Subclasses
    * Need a better list of work subclasses
    * These will all need individual input forms
    * Batch upload citation parser will have to be smart enough to assign proper subclass
    * Fix mappings for books
    * Add URL field for journal articles
  * Authors/Editors/Keywords/Tags
    * Currently, if you don't hit the add button they are not added, even if you hit save - confusing
    * It might be better to ask for a delimited list, and we do the parsing
  * Batch uploads
    * These take too long - the user needs to see something; also, the browser will time out
    * Review Batch needs to be more of a report of what went in, what errored, etc, as well as duplicates
  * Adding works directly to a person
    * Not doing anything currently
    * Should automatically verify contributorships for the person once the batch is confirmed
    * User should be alerted of works not matching any of his pen names, and allowed to add those pen names immediately
  * Bugs
    * ISSN/ISBN linked to publisher data, but if the latter is missing the ISSN/ISBN becomes associated with UNKNOWN
    * RIS import for year dates (e.g., PY - 2001) gets assigned as null
    * RIS citation importer ignores a lot of valid RIS tags

### Show a work ###
  * Need better display of the citation

### Delete a work ###
  * Delete a batch of works on a person
    * Needs a view for this - not yet possible
    * Needs to run as a background process; solr reindex

### Duplicate works ###
  * ~~List needs a facet for person~~
  * ~~Select and delete multiple duplicate works~~
  * Deleting a work that has duplicate(s) is not possible. Can we make this easier on the user?


## Solr/Searching/Faceting ##
  * Upgrade
  * People with no works don't show up on searches
  * People/Works has a hidden facet on Person, but the person's name still shows up in the list of facets -- needs straightening out
  * Indexes needed for
    * People
    * Groups
    * Publishers
    * Publications



---


# DEPRECATED / OUT OF DATE #

(May-2009) This To-Do list needs major updates! A more active To-Do list for our upcoming BibApp 1.0 release is available on the [InterfaceRedesign](http://code.google.com/p/bibapp/wiki/InterfaceRedesign) page of the wiki.


~~= BibApp To-Do: =~~

  * **Item (Timeframe | Owner)**

  * **1.0 Release**
    * Necessary Documentation Updates
      * Update Install documentation with `rake gems:install` to install all our Gem Dependencies.  Also add the following notes:
        * Note: on Ubuntu/Debian, auto-installing `libxml-ruby` may error out with:
```
          ERROR: Filed to build gem native extension.
```
        * If you see that error, make sure you have `libxml2` and `libxml2-dev` installed:
```
          sudo apt-get install libxml2 libxml2-dev
```
        * Then, re-run the `rake gems:install`
        * Another potential error:
```
          'require': no such file to load -- mkmf (LoadError)
```
        * Resolution is to install `ruby1.8-dev`
```
          sudo apt-get install ruby1.8-dev
```
      * Backend, asynchronous processing is only available for Linux / Mac OSX.  BibApp will still run on Windows, but will be a bit slower during many DB updates.  Therefore, BibApp is not recommended for Production on Windows.

  * **Documentation (Ongoing | Everyone - Eric)**
    * Admin Documentation
      * How to create citations, people, groups
      * How to edit authorities
      * How to verify/deny contributorships
      * How to archive research in a repository
    * Videocast of major interface features

  * **Authorities**
    * rake script to pull UW-Madison and UIUC authority data
    * Use Active::Resource

  * **Authorization (After JCDL | Anyone)**
    * Cleanup views having to do with adding/removing authorization roles... they could look a little nicer.

  * **Citations (Anyone | ASAP)**
    * **Bug** - Some bad publication date years (ex. 6) cause the citations/edit form's publication date year select options to range badly (ex. 1950-11)
    * **Bug** - Citation author names over 6 should be dealt with appropriately
    * **BUG:**  Book titles are not being captured as "publications".  This causes citations to book chapters/sections to always have an "Unknown" in them for the Book Title.
    * ~~**Bug** - YAML and JSON views are broken for citations, again...~~ (Seemingly fixed by 2.1 upgrade?)
    * [Bibliographic Ontology](http://bibliontology.com/) - ramifications? (Everyone | July conference call)
    * Deduplication
      * Admin Dupe view
      * Implement string distance methods?
      * Investigate [amatch](http://amatch.rubyforge.org/)
    * _Views requiring work:_
      * show view: needs major cleanup!
      * show view: Abstract / keywords show when copyright is clear
      * show view: Move links to archived content files up by the "Find It" link?  If file is archived in local repository, should we even show the "Find It" link?

  * **File Uploads** (Anyone | ?)
    * **Bug** - File upload does not work in Safari 3.1.1

  * **NameStrings - Done 2008.08.29 - EL**
    * ~~Make a "machine" friendly db column~~
    * ~~Create view to clean NameString~~
    * ~~RegEx Recipe~~
    * ~~Automatically add PenNames upon Person.create~~

  * **Search (Eric)**
    * **Bugs:**
      * ~~Add param for rows~~
      * ~~Add rows param to filters~~
      * ~~Add rows param to search form select options~~
      * `"Nano*"` and `"nano*"` return different results!?!
      * ~~**Bug** Sorting results when there is multiple filters results in the filters being combined into one filter.~~
      * ~~**Bug** The year filter gives back results with years other than that of the filter.~~ - This bug seems to be fixed and I believe it was linked to the 'nil' publication date problem in solr.
      * ~~Fix faceting to produce URLs like this example~~
        * ~~http://localhost:8983/solr/select?q=nature&facet=true&facet.field=publication_facet&fq=publication_facet:%22Nature%22~~~~


  * **Missing Features:**
    * Advanced Search?

  * **SHERPA RoMEO data (Eric)**
    * Sherpa's api data is not cached on their server
    * net/http will **always** timeout
    * added /public/sherpa/publishers.xml file
    * Publisher.update\_sherpa\_data method groks over this xml file
    * Update will have to be via a manual download
    * We'll include a local copy in BibApp truck

  * **Speed**
    * ~~Move more views entirely into Solr~~
    * Rails caching
    * Asynchronous tasks
      * Citation import especially
      * Investigate [beanstalkd](http://xph.us/software/beanstalkd/)
      * Investigate [Async Observer](http://async-observer.rubyforge.org/)
    * Session based IP/OpenURL path

  * **General Styles / IA (Ongoing | Eric)**
    * Print CSS (started...)
    * **Bug** `&heart;` displays poorly in some browsers (firefox 2 on mac), make an image of it.

  * **Terminology (June | Everyone?)**
    * Remove 'citation' terminology...replace with 'research'?

  * **People**
    * ~~**Bug** - editing Group/Memberships (ex. adding a title) throws the :after\_save methods to update all Person.citation in Solr~~
    * ~~**Bug** - Updating all Person.citations in Solr does not happen when a membership is deleted. This **must happen**.~~
    * _Views requiring work:_
      * new view - needs general cleanup...just a list of fields right now
      * new view - Need to **remove** the image\_url (no longer used), and default the "active" to checked (or remove it altogether).
      * index view - should allow filtering via group\_id
    * Display / Design: indicate a "stub" entry, versus a completed entry
      * CSS or image for doing this
      * Make this the default true in the database
    * _Missing Features:_
      * Delete people
      * Single page to add a person.  So, have all the following on the "Add a Person" page: personal info, upload image, add to groups.
      * Add Citations directly to a person.  This should automatically add the appropriate "contributorships" as they should be considered "verified" citations.

  * **Groups**
    * ~~**Bug** Deleting a group does **not** delete the groups corresponding memberships, causing many errors. See comment below.~~
    * ~~**Bug** You shouldn't be able to delete groups... just _hide_ them.~~
    * **Bug?** If you create a Group through "Add a Group" from `/groups`, that group ends up invisible (as it has no people added to it, and hence no citations).
    * _Views requiring work:_
      * index view - should allow filtering via (parent\_group\_id)
      * index view - Parent/Child groups presentation

  * **Memberships**
    * A person should be allowed to have multiple memberships to the same group.  This will require some new logic.  Currently throughout the application it is required that there only be one membership for each person and group.
    * ~~**Bug**: Adding a title to a membership does not save.  This is cause by Permissions. In the method "edit\_time" in the memberships controller, the call to 'permit'  does not allow an update, even if you should have permission.~~
    * _Views requiring work:_
      * index view: should list memberships for ?person\_id=2, or even better, show memberships for memberships/2-Matthew\_S\_Allen

  * **Pen Names**
    * _Views requiring work:_
      * new view: Suggestions are totally wacky... remove initial last\_name search?  This view is also quite buggy when you add/remove pen names!

  * **Contributorships**
    * _Views requiring work:_
      * show view: It'd be nice to have a way to check multiple citations and click "Verify" or "Deny" once.  It's a bit of a pain to go one-by-one when you know multiple are either valid or not.

  * **Publishers**
    * _Views requiring work:_
      * new view: Get rid of the giant selectbox for Authority.  We already can manage authorities via admin pages.

  * **Publications**
    * _Views requiring work:_
      * new view: Get rid of the giant selectbox for Authority. We already can manage authorities via admin pages.
      * new view: Get rid of the giant selectbox for Publisher.  That should be populated via autocomplete on a textbox.


  * **Citation ingest (June? | Conference call)**
    * Implement:
      * [ParsCit](http://wing.comp.nus.edu.sg/parsCit/) importer
        1. Website includes a sample Ruby API script
        1. Make Ruby plugin (Eric | Due: July 15th)
      * simple pubmed API ingest
        1. UW-Madison Ebling Library partners have experience here
        1. Hold meeting and report back (Eric | Due: July 15th)
      * simple ISI ingest
      * simple arXiv API
    * ~~Add newer RefWorks XML format~~
    * Better error handling for bulk ingest!
      * Currently, if one citation errors out, the entire bulk ingest process halts.  It'd be better to note which citations error, and provide an error report at the end of the bulk import.
      * Create error report (ex. X good | X bad results)
    * _Missing Features:_
      * ~~Option to upload a file, instead of cut-and-paste for "Add Citations in Bulk"~~


  * **Citation export (Aug/Sept)**
    * Liam M. has released citeproc-rb v0.0.1
    * ~~Create a simple bibapp filter for the citeproc gem~~
    * ~~Localize CSL transformation xml files~~
    * ~~Bug: Authors are sorted alphabetically~~
    * Sorting citations is odd:
      * APA  - desc by primary author
      * IEEE - dunno?

  * **SWORD** (Tim | July?)
    * Test Fedora
    * Test Eprints
    * Bulk send?

  * **Tests (Ongoing | Everyone?)**
    * Add Fixtures
    * Write functional tests for all controllers
    * Write unit tests for all models