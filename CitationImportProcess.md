# Introduction #

Citation management starts with the import of new citations.  This page details how new citations are parsed, processed and loaded into BibApp.

# Import Formats #

BibApp currently accepts the following citation import formats:
  * **[RefWorks](http://www.refworks.com/) XML** - Refworks' currently supported XML export format.
  * **[RefWorks](http://www.refworks.com/) XML** (deprecated) - This XML export format has been _deprecated_ by RefWorks.  This deprecated XML format is _different_ from the new "RefWorks XML Format".
  * **[PubMed's](http://www.ncbi.nlm.nih.gov/PubMed/) MEDLINE format**
  * **[RIS](http://www.refman.com/support/risformat_intro.asp) format**

BibApp also supports manual entry of citations through a Citation web form.  There are already plans to support further formats, so feel free to make suggestions!

The citation parsers and importers for the above formats were developed specifically for BibApp.  They are available in the `/vendor/plugins/` directory when you download BibApp.  Once they are more stable, they will likely also be available as Rails Plugins.

# Citation Status #

The status of a citation is an important part of the lifecycle and visibility of the citation in BibApp.  Citations currently undergo the following status values:

| **Status** | **Description** | **Visibility** |
|:-----------|:----------------|:---------------|
| _processing_ | Citation has been successfully parsed, but it waiting on further processing | Citation is not visible |
| _duplicate_ | The system has reason to suspect this _citation_ is a duplicate.  It will be removed from the system during next cleanup. | Citation is not visible |
| _accepted_ | Citation is complete and has been accepted into BibApp | Citation is visible as normal |
| _incomplete_ | Citation is missing information and requires review. | Citation is visible, but somehow marked as incomplete |
| _deleted_ | Citation has been marked for deletion, and will be removed during the next cleanup. | Citation is not visible. |


# Import Process #

The citation import process is detailed graphically in the below **Citation Import Flow Chart**.  This section describes this step-by-step process in a little more detail.

  1. **Citation Parsing** - Based on the import format (_see above_), the citation is parsed into its various components.  The parsed citation is only available in system memory.
  1. **Completion Check** - The parsed citation is checked for completeness.  For BibApp, "completeness" is defined as having all the necessary fields which BibApp uses to check for duplicates.
    * The fields currently required for "completeness" include (_these fields are not finalized!_):
      * year
      * start page
      * title OR (first author and ISSN/ISBN)
    * **Duplication Check** - Assuming the new citation is found to be complete, BibApp searches the existing citations to determine if this new citation is a duplicate.
      * If it is a duplicate, the new citation is discarded and the user is notified the citation was a duplicate.
      * If it is not a duplicate (or it cannot be determined) the citation is marked as "accepted" and the process continues.
  1. **Determine Contributorships** - As one of the more complex processes within BibApp, the decision process of how we determine or "guess" contributorships is detailed on the [AuthorAuthorities](AuthorAuthorities.md) page.
  1. **Extract External Identifiers** - Citations which are pulled from external systems often come with unique system identifiers (e.g. a PubMed ID, OCLC #, LSSN, etc.)  Rather than discard these external system identifiers, we save them for later processing.  The hope is that "incomplete" (or potentially incorrect) citations can be filled out in more detail by querying these various external systems using the unique identifier(s).
    * For example, if we have an "incomplete" citation but we were given its PubMed ID, we can potentially kick off a behind-the-scenes process to pull down any missing citation information from PubMed using that unique PubMed ID.
  1. **Extract Publication Information** - Publication (e.g. Journal Title) and Publisher information is also a complex problem in BibApp.  As anyone who has seen many citations can attest, publication and publisher names never seem to appear the same way twice!  Dealing with "Authorities" for Publication and Publisher names is being detailed on the [PublicationPublisherAuthorities](PublicationPublisherAuthorities.md) page
  1. **Save Citation** - Assuming **all** of the above steps have completed without errors, the new citation (and related extracted information) is saved into the BibApp database.  If any processing resulted in an error, the user who entered the citation is informed and the citation is _not_ saved.

# Citation Import Flow Chart #

The below diagram attempts to layout the processing that occurs whenever a new citation is imported into BibApp.  Click on the diagram to view a larger version.

[![](http://www.gliffy.com/pubdoc/1371391/M.jpg)](http://www.gliffy.com/publish/1371391/)