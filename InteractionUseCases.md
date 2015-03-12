# Personas #

**NOTE:** This list of personas interacts with the underlying data.

In Alan Cooper style, here is a list of named characters we might expect to interact with the BibApp:

**Dr. Helen Troia: Assistant Professor, Department of Basketology, Achaea University**

Dr. Troia is going up for tenure at Achaea University next year. She hopes that the BibApp will help her prepare her CV for her tenure package. She already uses it to keep her departmental webpage up-to-date, as she has very little time to update the page herself. Dr. Troia has heard vaguely that open access threatens her favorite publisher, but does not have strong opinions on the subject herself.

**Cassandra Athens: Webmaster, Department of Basketology, Achaea University**

Cassandra just started maintaining the Basketology websites. She is eager to help Basketology put its best face forward, though the new web-design guidelines coming down from the university's communications department cramp her style. Whatever the BibApp can easily do to reduce Cassandra's workload is welcome -- but Cassandra warns you, it had better work with her existing content management system!

**Menelaus Fox: liaison librarian to the Department of Basketology, Achaea University**

The Basketology department is coming up for reaccreditation soon, and Menelaus is tasked with evaluating the library's Basketology collection, and bolstering it where necessary. He is interested to know where Basketology faculty publish. Menelaus is not very tech-savvy, and he is perennially pressed for time. He doesn't know anything about open access or self-archiving.

**Ulysses Acqua: manager, university library's DSpace repository, Achaea University**

Ulysses knows he must fill the repository he runs as quickly as possible if he is to keep his job. He is an enthusiastic booster of open access. He has a reasonable level of technical savvy, but DSpace confuses him at times.

**Senator Pylia Nestor: state senator**

Senator Nestor is a staunch supporter of Achaea University; in tough budget times, she needs all the political ammunition she can scare up. Basketology is a hot field these days; if Senator Nestor can demonstrate that the university is active and influential in this field, she can impress her colleagues. She would like her staff to be able to find recently-published articles on Basketology by university faculty, reporting numbers back to her for use in a floor speech. If they can download full-text, so much the better.

**Paris Ilium: prospective graduate student**

Paris is a senior at Troy Tech, interested in graduate study of Basketology. He is surveying websites for the top Basketology departments in the country. The slicker and more up-to-date a departmental website seems to him, the more impressed he is with the department. He also appreciates knowing what faculty research specialties are (as represented by their interest statements and recent publications), and how faculty present themselves and their interests online.

**Andromache Elis, journalist**

Andromache often has to write news stories about events or phenomena outside her sphere of knowledge. She relies on Achaea University to turn up experts in the most bizarre specialties imaginable. She would love a central place to keyword-search faculty listings to turn up people she can interview.

**Dr. Asklepios Caduceus, Basketologist, University of Crete**

Asklepios is a well-known senior Basketologist, chair of the Basketology department at the University of Crete. He edits one of the top journals in the field. He has an opening in his department, and is looking over Basketology websites for young up-and-comers he might raid from their current institutions. He is also perennially interested in finding capable peer-reviewers for the journal he runs.

# Interactions #

  * An automatically-updated list of publications for a faculty member's website. Should be style-able and usable with generic CMSes (Cassandra, Helen)
    * Citation groupings?
    * Like Feed2JS?
    * What about citation styles -- could leverage Zotero citation export code? CSL (XML citation format) http://xbiblio.sourceforge.net/csl/
    * Preferences - Choose a citation style or organization setup and preview the results.
    * No auth necessary for the export piece; many different people on campus will want the exported info.
    * What about server load? Caching? Updated nightly? Asynchronous workers (via cron)?
    * Building random collections of cites, perhaps via faceted search/browse. (Senator Nestor)
    * RSS feeds!
  * A well-formatted list of publications to be imported into word-processing software for a CV. (Helen)
    * to Endnote or RefWorks
    * dump an RTF
    * let them copy/paste text
  * A report of the journals Basketology faculty have published in (Menelaus, Senator Nestor)
    * top X journals
    * journal authority? publisher authority?
  * Adding a new faculty member to the department's BibApp instance; previous publications must be imported, a new faculty webpage generated, and photo and descriptive information added (Helen, Cassandra, Menelaus?)
  * Adding publications to a faculty member's BibApp site as they appear (Helen, Menelaus, Cassandra)
    * Import function (batch) - who can do it? authorization
    * what about approval?
    * Encoding for cut-and-pasted citations?
    * TinyMCE gizmo for cut-and-pastes from Word?
    * Wisconsin Tech Search's form? Borrow their sanity-checking code?
    * asynchronous worker to avoid server load at batch import; request submitted right away, but results may not be instantaneous.
  * Searching & Browsingthe Basketology department for interesting new research (Helen, Andromache, Senator Nestor, Paris, Asklepios)
    * Solr - better understanding of capabilities - spell check, "find similar research"
    * Solr in Aquifer project - talk to Tom Habing (UIUC)
  * Receiving a feed or emailed notification of new research based on defined search terms (Helen, Asklepios)
    * creating feed from search - similar to first interaction in this list
  * Automatically notifying a faculty member by email that a preprint or postprint is eligible for repository deposit (Ulysses or Menelaus)
  * Easily adding a preprint or postprint for deposit into the repository, with all necessary embargoes handled automatically (Helen)
    * Way to actually **save** a preprint/postprint into BibApp ("staging repository")
    * Once a preprint/postprint goes into archival repository it's cleaned from BibApp?
    * 'attachmentfu' rails plugin may help with this?
    * NIH content a part of this?
    * BibApp should NOT handle embargo? - BibApp may communicate the embargo period to an archival repository, but the repository needs to handle the actual embargo?
  * Establish authority forms for journal titles and publishers. (Menelaus)
    * Scrape OCLC or Ulrich's? OCLC ISSN web service? http://xissn.worldcat.org/xissnadmin/index.htm
    * XML dump of one BibApp instance's publisher/title authority info, for import into someone else's instance.
  * Person wants to import a citation into their favorite reference manager. (Helen, Paris, Asklepios)
    * COinS?
  * Create a new group in BibApp and add people to those groups in a relatively automated fashion?
  * People who leave University...what happens in BibApp?
    * Need a way to show they are NOT in the university anymore.  However, they should still remain in BibApp.  Should also be able to export data to another institution using BibApp
    * Need a start/end date for people at University.  Useful to filter out citations appropriately
  * What if a Group changes name or is subsumed into another Group
    * a way to be able to look historically at groups.  What did this group look like and publish in 10, 20 years ago
