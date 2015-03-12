# BibApp Interface/Workflow Redesign for 1.0 #

These notes are from the BibApp Meeting in Madison, Wisconsin from September 29-30, 2008.  During that meeting, we did a full review of the current BibApp interface and workflows (to get content into system and out).  These notes detail the brainstorming results of those discussions.

Suggested changes are organized by area of the BibApp application below.  These notes are based on the absolute latest BibApp code (which has changed since the 0.7 release).

As a reference, you may browse through the UIUC demo site available at:
http://www.library.uiuc.edu/bibapp/


## General Layout ##

Overall, the general layout looks good. However, the following changes are suggested:

  * **Header:**
    * ~~Why is the Institution name at the same level as FAQ and Login (in upper right)?~~
      * ~~It's already listed in the footer...not necessary in upper right corner~~
    * Header should provide an "About" link which (by default) will give more information about BibApp software.  However, institutions can change this default content.
    * ~~"BibApp" is a good software name, but it's unlikely any institutions will want to call their installation "BibApp".  We need to make the Header more configurable!~~
      * ~~Need to allow for a custom image for site (to replace "BibApp logo")~~
      * ~~Need to allow for a custom tagline in header (and at the top of the homepage)~~
        * ~~Current tagline ("We're putting 100 papers online, for free. This is true.") is probably inappropriate for BibApp.  We need a better tagline that represents BibApp software.~~
  * **Footer:**
    * We may need a "Contact Us" link somewhere?
  * **Themes/CSS:**
    * We decided themes won't make it into BibApp 1.0. However, many basic changes (e.g. color scheme) can be made via changes to the default CSS.


## Search ##

  * We need to be able to search at **any level** of application (not just globally)
    * Search within a Publisher, Group, Person, etc.
  * ~~Advanced Search~~
    * ~~In personalize.rb, able to customize the examples are underneath each search field~~
  * ~~Need to add "Advanced Search" link in header (currently you click on "Search" to get to Advanced Search area)~~
  * ~~After a search that returns **zero results**~~
    * ~~Display a message stating that no results are found~~
    * ~~Add the "Advanced Search" form directly to the page, and suggest that the user may want to perform a more advanced search.~~


## Browse Groups ##

  * ~~Make into a table of columns with basic information~~
    * ~~Table should be "zebra-striped"..but, very subtle~~
    * ~~Remove numbering, it's not necessary~~
  * ~~A-Z browsing~~
    * ~~Get rid of the letter in parens after title. Instead, highlight the current letter in the A-Z letter list.~~
    * ~~Add A-Z letter list at bottom of page~~
  * Should have a search box at top, to immediately filter for certain words in name
  * Is there any way to easily provide cross listing of group names?
    * (E.g.) "Center of Mathematical Sciences" => "Mathematical Sciences, Center of"

## Browse People ##

  * ~~Make into a table of columns with basic information~~
    * ~~Table should be "zebra-striped"..but, very subtle~~
    * ~~Remove numbering, it's not necessary~~
    * ~~Basic information should include:~~
      * ~~Thumbnail of person~~
      * ~~Name~~
      * ~~# of total works in BibApp~~
      * ~~Citation to his/her most recent publication.~~
  * ~~A-Z browsing~~
    * ~~Get rid of the letter in parens after title. Instead, highlight the current letter in the A-Z letter list.~~
    * ~~Add A-Z letter list at bottom of page~~
  * Should have a search box at top, to immediately filter names

## Browse Publications ##

  * ~~Make into a table of columns with basic information~~
    * ~~Table should be "zebra-striped"..but, very subtle~~
    * ~~Remove numbering, it's not necessary~~
  * ~~A-Z browsing~~
    * ~~Get rid of the letter in parens after title. Instead, highlight the current letter in the A-Z letter list.~~
    * ~~Add A-Z letter list at bottom of page~~
  * Should have a search box at top, to immediately filter names
  * Should have faceted "types", so that you can browse just journals, or just books, etc.

## Browse Publishers ##

  * ~~Make into a table of columns with basic information~~
    * ~~Table should be "zebra-striped"..but, very subtle~~
    * ~~Remove numbering, it's not necessary~~
    * ~~Basic Info to show:~~
      * ~~Name~~
      * ~~# of publications in BibApp~~
      * ~~Most recent year of publication~~
  * ~~A-Z browsing~~
    * ~~Get rid of the letter in parens after title. Instead, highlight the current letter in the A-Z letter list.~~
    * ~~Add A-Z letter list at bottom of page~~
  * Should have a search box at top, to immediately filter names
  * Should have faceted "types", so that you can browse just journals, or just books, etc.

## View A Person ##

  * ~~Tabbed view (more like Vivo, others).  There is too much content on one page & too much scrolling~~
    * ~~Entire works list (with filters) should be in a separate **tab**~~
  * What about last name's under co-author images?  Is last name only in appropriate, or should we have the full name?
  * Numbers on co-author person image...will anyone understand them??
  * Do we really need pictures of co-authors - Why not just a small table listing full names (and # of publications)
    * Name (in first column)
    * # of joint publications (in second column) - put # in a circle & give some color
  * What is the red X in "Refine Results" -> Use word "remove" instead of Red X
    * Make More like a traditional add/remove shopping cart
  * Don't like the heading "Works"
    * More ownership?  "John Smith's Works"
  * The way in which a Person's name appears should be configurable (to an extent).  Right now we don't display middle initial or middle name.  However, for folks who actually go by their middle name, they'd obviously want an option to display their name differently!

## Add to Cart / Export Functionality ##
  * Question: What is Add to Cart??  (need to make this clearer somehow)
  * Send To:
    * This should export it into a Text file (in APA, etc.)
    * Or, we could export to a giant text area.
  * Need an Export to various formats.
    * For 1.0, we will build an export to RIS.  However, it will be a general "plugin", so that we can add more export formats afterwords
  * COinS - we need to implement so that folks can easily save research from BibApp into Zotero, and similar.
  * What about ability to "Add to Delicious" or other easy linking/export features?

## View Group ##

  * ~~Should have tabbed views, to limit the amount of scrolling on a page~~
    * ~~Browse People~~
    * ~~Browse Works~~
  * It always shows **EVERYONE** in a group.  This makes for a very large page when you have large groups of people.
    * Instead, show just the following 10 people by default:
      * Department/Group Chair(s)
      * The most prolific faculty in this group, up to total of 10.
    * Allow option to Browse People by a particular group, to see everyone.
  * It'd be nice to get more feedback about this page.  What do **departments** want shown on this page by default?


## View Publisher / Publication ##

  * Should have tabbed views, to limit the amount of scrolling on a page
  * The "People" heading is misleading.  Should be more specific based on current context:
    * E.g.) "People who published in 'Academic Press'"
    * Heading text should be in a lighter gray (so that it is less bold on page)??


## Authentication ##

Currently, BibApp only comes with authentication against usernames/passwords stored locally in the BibApp database.

  * We need to be able to support campus-based authentication (and be relatively easy for other institutions to extend or build custom authentication)
  * Associate "People" with "Users"
    * Currently, an authenticated "user" is not auto-associated with his/her "person" homepage in BibApp.  If a faculty member logs into BibApp, he/she should be able to quickly update his/her "Profile", to easily update his/her Person homepage in BibApp.

## Roles ##
  * "Add Administrators" link next "Administrators" and turn into buttons (rather than links)
  * Text to explain difference between two roles.  What extra rights does an "Administrator" have?
  * Once we do campus authentication, we need to link Users of system to People
> (so that we can auto-create these roles)


## Admin Page ##

  * ~~Should have an easily browseable list of all available admin functions:  "Add Group, Add Person, etc."~~
  * Functions that are missing:
    * Delete People
    * Delete Groups
    * Delete Publications/Publishers
    * Delete Works
    * Need to be able to remove/correct authorities
    * Need to be able to generally correct mistakes or easily delete content from BibApp
    * ~~Need to be able to manage/remove duplicates from system~~

## Add a Person ##

  * ~~Text should say search "Campus Directory" instead of LDAP! (most won't know what "LDAP" means)~~
  * ~~"Use Me" text for matches from LDAP => needs to change to "select" or something?~~
  * ~~What does "active?" option do? Eric & Tim think it is obsolete, so we should remove it.~~
  * LDAP search is buggy...needs fixing
    * UW gets back title & group information for names that match
    * UIUC gets back title & university name for names that match
    * We need to be able to allow for customizing of the returned fields from LDAP
    * Also look at First & Middle names...may need to split/parse these, since LDAP tends to put them both in a single "given name" field.
    * What if you do a generic search for "Smith"
      * ~~**Bug:** we get no results in BibApp...campus directory returns "too many results"~~
    * ~~Need a recommended format for searching names (e.g. "Smith, Mark")~~
    * Strangely, "Mark Smith" returns different results from "Smith, Mark"
  * Auto-add to group (with appointment title) with the departmental information returned from LDAP search.
  * If only one results for a LDAP person search, we should auto-populate the form fields below
  * ~~Need ability to clear the form, in case we accidentally got a bad match.~~
  * If person already exists in BibApp system...we should return a "did you mean" with a link to the existing person (rather than creating a duplicate person!)
  * ~~The Add a Person page should actually be one big form that allows you to do **all** of the following:~~
    * ~~Add an Image~~
      * Should also be able to enter a URL for the image (rather than an upload)
    * ~~Add a Group~~
      * ~~Ability to type in a name~~
      * Nested List of Groups (similar to our nested Communities in DSpace)...**all groups** in a javascript hierarchy
      * "Title" for Group => "Appointment"
      * Get rid of checkbox...Just add a "remove" link to remove affiliation
      * Get rid of numbered list
    * Ability to "Add Another" for fields which allow multiple values
  * ~~Should be a two column form to save space~~
  * ~~"Pen Name" should be on a **different** form (or different tab?)~~
    * Pen Names => "Publishes under these names"
    * **BUG:** Adding additional pen names doesn't seem to be working right.
  * Need to be able to enter a Primary Title/Appointment to display on a person's page
  * Titles/Appointment within a group are never displayed by BibApp.  Should they also display on the person's page (maybe as part of the "Groups" listing)?

## Add Work(s) ##
  * ~~Ability to add work(s) directly to a person~~
    * ~~These works should be auto-verified, so that they appear **immediately** on the Person page.~~
  * ~~Be able to move authors up and down in the list of authors.  The **ordering** of authors matters, and we need to allow people to change this order easily!~~
  * Can we add back the ability to add Works from an RSS feed (this used to be in the initial version -- BibApp 0.4)?  This was an easy way to subscribe to updates (from various Article & Indexing services) and import content to BibApp easily.  (Maybe this would also allow us to pull in new content added to a repository?)

## Review Batch Import ##
  * Add links to your next tasks
    * Add People, update contributorships, etc.
  * Also an "Add more..." link


## "Ready to Archive" listing ##
  * Need ability to archive many at once (checkboxes)
  * Should be a table with the following info:
    * Citation
    * Link to File(s)
    * SHERPA info about source
  * Should have Pagination
  * Button to actually submit many via SWORD
  * Should stay on this page after archiving...just show a "flash" that the archiving was completed successfully.

## SWORD Info ##

  * Change text "Deposit immediately via SWORD" => "Deposit immediately to IDEALS"
    * **Bug:** There's no condition here!  This should be an "Admin-only" task
  * Change text "Archive Research"??


## Verify Contributorships (Admin Interface) ##

  * Make this interface and the interface for a particular **person** look more similar.
  * Group works by person
  * Open up in list (plus/minus hierarchical list?)
    * List of Groups who have people with unverified works (count of people?)
    * List of People who have unverified works (count of unverified per person)
    * Be able to check all and verify all at once!

## Make Authorities (Publishers/Publications) ##

  * Needs to be searchable!
    * Search for "Elsevier" => see everthing with Elsevier in it
    * Search for "Blackwell" or "Wiley" => get results from both and make authorities from there.
  * Checkboxes for selecting -- rather than "select"/"remove" options
  * ~~Once you click "make authority", a button should appear next to it which says "save"~~
  * No feedback on which ones are already "authorities"
    * Need a pulldown list of varients which belong to an authority
    * Need a way to then undo existing authorities (if you made a mistake)
  * Filter or Tab - (e.g.) only view items which have no authority assigned, or are not already an authority themselves