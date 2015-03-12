| _Note:_ As we are a small development team (with limited resources), Roadmap plans may change.  However, we are working hard to keep these releases on-schedule.  We will keep this page up-to-date if any unanticipated release changes occur. |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

## Version 0.7 | JCDL 2008 ##

  * ~~Basic Authentication~~
  * ~~Authorization~~
  * ~~Basic authorities~~

  * ~~Solr~~
    * ~~Faceting~~
    * ~~Spelling suggestions~~
    * ~~Related articles~~

  * ~~SWORD~~

## Version 1.0 | Summer 2009 ##

  * ~~Rails 2.1 upgrade~~
    * ~~Gem dependencies~~
    * ~~Refactor for named scope~~
  * ~~Speed increases~~
    * ~~Increase page loading speed by using Solr more heavily~~
    * ~~Increase processing speed for updates by using more backend processing~~
      * Note: backend processing only currently enabled for Linux and Mac OSX
  * ~~User requested features:~~
    * ~~Tagging~~
  * ~~Enhanced citation importing~~
    * ~~Better error handling / report messages~~
  * ~~Terminology change:  "citations" => "works"~~
  * ~~Advanced Search~~
  * ~~Add to Cart:~~
    * ~~Pagination~~
    * ~~Send to various formats (via citeproc-rb)~~
  * ~~Simple citation formatting~~
    * ~~citeproc-rb~~
  * ~~Upgrade bug fixes~~
  * InterfaceRedesign
  * ToDo list
  * Bugs to Fix (moved here from Interface Redesign)
    * Books and Book Chapters are not yet displayed properly in BibApp.  The Book Title always appears as "Unknown".
    * Web Services (extracting data via YAML, XML, JSON/JSONP, etc.)
    * ~~Upgrade process from 0.7 to latest code is a bit buggy because of the rename of "Citations" to "Works".  We need to smooth this out, to make it an easy upgrade from 0.7 to 1.0.~~
    * We need to upgrade to the **stable** Solr 1.3.0.  We're still running on a nightly build.
  * ~~Update SWORD plugin to use SWORD 1.3~~
  * User requested features:
    * Simple citation widgets ([Exhibit](http://www.simile-widgets.org/exhibit/))
  * Export citation data in RIS
  * Polymorphic Identifiers
  * Publications Model subclasses
    * Books
    * Journals
  * COinS
  * Publicly tested
  * Stable release

## Future Development ##
  * Enhanced author-disambiguation
  * Import citation data in more formats
  * Themes
  * FOAF views
  * Highlight citations
  * BibApp interoperability
  * Improve SHERPA data
  * Focus on current campus collaboration
  * Cited references
  * Potentially automate deposits to PubMed Central?