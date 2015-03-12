# Introduction #

This is a list of views, their purposes, and interaction requirements.

# Details #

### Citation Views ###

Citation data.

  * **Index/List**
    * Purpose: Provide a list of all the Citations captured within the application.  Citations can be "claimed" or "unclaimed", which indicates their mapped association to People within the database.
    * UX: Solr - filter, sort, search
    * Links: IP address "smart" OpenURL, direct link (if captured in IR)
    * Params: ?status=archived
  * **Show**
    * Purpose: Provide a "full" view of the Citation and associated data.
    * Formats: HTML | XML | JSON | CSL
    * Includes: People, Groups, Tags
    * Wishlist: Count of views, downloads
  * **New/Edit**
    * Purpose: Add a new Citation or edit an existing Citation to the application
    * UX: Ajax auto-suggest for authors, publications, nice JS for tagging
    * Upload File(s?)

### People Views ###

  * **Index/List**
    * Purpose: Provide a list of all People within the application
    * UX: A-Z pagination, Ajax lookup/filter
  * **Show**
    * Purpose: Provide a "full" view of a Person and their associated data.
    * Formats: HTML | XML | JSON | FOAF
    * Includes: Research Description, Memberships, Contributorships
    * UX: Solr-based contributorship filtering (search,facets,sorting)
  * New
  * Edit

### NameStrings Views ###

  * Index/List
  * Show
    * Includes:
      * Citations

### PenNames Views ###

  * Index/List
    * Person
  * New/Edit/Destroy

### Group Views ###

  * Index/List
  * Show
    * Includes:
      * People
      * Contributorships
  * New
  * Edit
    * Set Parent Group

### Membership Views ###

  * Index/List
    * Person
  * New/Edit/Destroy

### Contributorship Views ###

  * Index/List
    * Person
    * Group
    * Archival Analysis
  * Show
  * Verify/Deny

### Publisher Views ###

  * Index/List
  * Show
  * New
  * Edit
  * Authorities

### Publication Views ###

  * Index/List
  * Show
  * New
  * Edit
  * Authorities

### ExternalService Views ###

  * Index/List
  * Show
  * New
  * Edit

### Search ###

  * Results

### Administration Views ###

  * Authentication
    * Login
  * Authorization
    * Grant rights
    * Destroy rights
  * Archiving
    * Package
    * Process
  * Citations
    * Duplicates
      * View "close" duplicates
      * View "possibles": no-dupe-key citations
  * Contributorships
    * Mass Verify/Deny
  * Personalize
    * Configuration