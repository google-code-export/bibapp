# Introduction #

Once citations have been [imported](CitationImportProcess.md) into BibApp, there are ways to export them into other formats/systems.

In BibApp, _exporting_ a citation should not be confused with _archiving or packaging_ a citation.

**Exporting** a citation is essentially obtaining a copy of the citation in whatever electronic format (e.g. BibTeX, EndNote, etc.) you deem necessary.

**Archiving** a citation is a special type of 'export' where the citation and associated content files are used to generate a submission information package (SIP) which can then be sent to a supported archival system (e.g. DSpace, Fedora, EPrints, etc.)

# Export Formats #

Exporting a citation gives you a copy of the citation in a format of your choice.  Currently, BibApp _plans_ to provide the following citation export formats (_These are not finalized!_):
  * **[BibTeX](http://www.bibtex.org/) format**
  * **[EndNote](http://www.endnote.com/) format**
  * **[Citation Style Language (CSL)](http://xbiblio.sourceforge.net/csl/)**
  * **RSS feeds** - via [Feed2JS](http://feed2js.org/)?

# Package Formats #

After associating content file(s) with a citation, you can generate a Submission Information Package (SIP) suitable for sending to the archival system of your choice.

Currently, BibApp _plans_ to generate the following SIP formats (_These are not finalized!_):
  * **[Simple Web-service Offering Repository Deposit (SWORD)](http://www.ukoln.ac.uk/repositories/digirep/index/SWORD) Atom Publishing Protocol (APP)** - As SWORD will soon be supported by [DSpace](http://www.dspace.org), [Fedora](http://www.fedora.info/) and [EPrints](http://www.eprints.org/), the SWORD Atom protocol can be used to submit packages to any of these systems
  * **National Institute of Health (NIH) acceptable format** - The exact format is TBD, but we want to help meet the requirement that NIH funded research needs to be deposited in [PubMed Central](http://www.pubmedcentral.nih.gov/)

Any additional SIP formats are TBD.

# Citation Archival Status #

The status of archiving a citation helps BibApp administrators to keep track of which citations can be archived, which are impractical to archive, etc.  Citations currently undergo the following Archival status values:

| **Status** | **Description** |
|:-----------|:----------------|
| _Not Ready, rights unknown_ | This is the initial archival status for all citations.  The Citation has not been analyzed for archiving. |
| _Ready for archiving_ | The system has determined that this citation could be archived (based on information received from [SHERPA RoMEO](http://www.sherpa.ac.uk/romeo.php). |
| _Archiving is impractical_ | A BibApp Administrator has determined that it would be impractical to attempt to archive this citation.  Likely, there are either Copyright/IP issues with archiving, or else there is no content file available. |
| _File collected_ | The content file(s) associated with the citation have been located and collected.  They have been uploaded into BibApp. |
| _Ready to generate export file for repository_ | All content file(s) have been located, and necessary permissions have been obtained to allow this citation to be archived. |
| _Export file has been generated_ | A repository-ready SIP (Submission Information Package) has been exported from BibApp.  This SIP includes the content file(s) along will all necessary citation metadata. |
| _Repository record created, URL known_ | The repository-ready SIP was accepted into the repository, and a unique URL was returned.  This URL has been linked to from the citation in BibApp. |

# Archiving Process #

The citation archiving process is detailed graphically in the below **Citation Archive Flow Chart**.  This section describes this step-by-step process in a little more detail.

**Prerequisites:**
  * Citations must have a status of "accepted" before they can be archived.  For more information on Citation Status values, see the CitationImportProcess

**Process:**
  1. **Attach Content File(s) to Citation** (_User_) - A BibApp User uploads content file(s) which correspond to a particular citation in the system.   A folder is generated with the `citation_id` of the citation, and the citation's content file(s) are temporarily saved there.
  1. **Accept Archive License Agreement** (_User_) - The BibApp User must also accept the license agreement for whatever archival system the content is being sent to.  This should likely happen at the same time the content file(s) are attached.   Once a user has signed the agreement _and_ attached content files, the citation is given a status of "archive pending".
  1. **Observer Notifies Admin** (_Automated_) - A BibApp Administrator is notified whenever citations are updated to the "archive pending" status.  Once there are one or more citations marked with this status, the Administrator can choose to generate packages for these citation(s). (_This will likely be a manual process to kick off package generation, at least initially._)
  1. **Initial Packaging Process** (_Admin_) - The BibApp Administrator generates "archive-ready" submission information packages (SIP) for citations marked "archive pending".  These packages are stored locally for now.
  1. **Package Sent to Archive** (_Admin_) - Depending on the archival system, this process may be automated, semi-automated, or entirely manual.  In some way the archival system is given the generated submission information packages.  In return, BibApp expects the archival system to provide a URI for the final, archived item.  This URI is important since it allows BibApp to provide a link to the downloadable content within the archival system.
  1. **Update Citation Information** (_Admin_) - Once the citation's package has been accepted into the archival system and a URI has been obtained, the BibApp Administrator updates the citation information in BibApp to include this new URI.  In addition, the temporary content files are removed from BibApp

_Note:_ All steps marked "(_Admin_)" above are likely to require some manual intervention to be carried out by a BibApp administrative user.  In future versions of BibApp, some of these steps may be better automated.


# Citation Archive Flow Chart #

The below diagram attempts to layout the processing that occurs when a citation has content files associated and is approved for sending to an archival system.  Click on the diagram to view a larger version.

[![](http://www.gliffy.com/pubdoc/1371427/M.jpg)](http://www.gliffy.com/publish/1371427/)