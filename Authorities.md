# Introduction #

Citation data is ugly.  We need to create authority records for Authors, Publications and Publishers.


# Details #

Citation data collected for 48 People in the Engineering Physics department at UW-Madison produces:

  * 4512 unique AuthorString records
  * 1282 unique Publication records
  * 0431 unique Publisher records
  * 3053 unique Citation records

# Goals #

The BibApp's RESTful design can help streamline citation authority control.  The initial production installations at UW-Madison and UIUC will help create a database of normalized Publication and Publisher authorities.  These authority records will be made available to every successive installation, helping new BibApp users begin their service with beautiful data.

# Authorities #

  * PublicationPublisherAuthorities
  * AuthorAuthorities