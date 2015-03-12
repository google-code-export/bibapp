**Bold type** means a field that doesn't seem to exist in the table yet.

# Schema #

```
  create_table "works", :force => true do |t|
    t.string   "type"
    t.text     "title_primary"
    t.text     "title_secondary"
    t.text     "title_tertiary"
    t.text     "affiliation"
    t.string   "volume"
    t.string   "issue"
    t.string   "start_page"
    t.string   "end_page"
    t.text     "abstract"
    t.text     "notes"
    t.text     "links"
    t.integer  "work_state_id",         :limit => 11
    t.integer  "work_archive_state_id", :limit => 11
    t.integer  "publication_id",        :limit => 11
    t.integer  "publisher_id",          :limit => 11
    t.datetime "archived_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "original_data"
    t.integer  "batch_index",           :limit => 11, :default => 0
    t.text     "scoring_hash"
    t.date     "publication_date"
    t.string   "language"
    t.text     "copyright_holder"
    t.boolean  "peer_reviewed"
    t.string   "machine_name"
  end

```

## General Fields to Add to All Types ##

  * funder
  * notes

Also note that we need to add a location field to the Publisher entity in order to properly display the citation for books.

## Book (whole) ##

Contributors:
author, editor, translator, illustrator

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * end\_page (should equal number of pages; so displayLabel=Pages)
  * publisher\_id
  * publication\_date
  * language
  * copyright\_holder

## Book (section) ##

Contributors:
`*`section author, book editor

(otherwise same as book?)

## Monograph ##

(same as book)

## Journal article ##

Contributors:
`*`author

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * start\_page
  * end\_page
  * `*`publication\_id
  * publisher\_id
  * `*`publication\_date
  * language
  * copyright\_holder
  * abstract
  * **url-like identifier** (DOI, Handle, whatever)

## Journal (edited) ##

Contributors:
editor (editor in chief, managing, consulting (though this sometimes means the same as an editorial board member ), board member, ~~peer reviewer?~~ (I'm not sure that we need this one right now)

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * publication\_id
  * `*`publisher\_id
  * **start date** - need to connect this to the contributor role, however, since it's less about the work then about the time spent as editor; this is probably too complex for 1.0 so we need to make it clear in the display that we're referring to the role.
  * **end date** - need to connect this to the contributor role, however, since it's less about the work then about the time spent as editor; this is probably too complex for 1.0 so we need to make it clear in the display that we're referring to the role.

## Conference paper ##

Contributors:
`*`author

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * publication\_id
  * publisher\_id
  * `*`**conference title**
  * **conference location**
  * **conference dates**
  * start\_page
  * end\_page
  * copyright\_holder
  * abstract
  * date (I've noticed that some conference proceedings are published later than the actual conference - do we need to call out the publication date separately?)

## Conference poster ##

Contributors:
author

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * `*`**conference title**
  * **conference location**
  * **conference dates**
  * copyright\_holder (automatically same as author - probably not)
  * abstract

## Conference proceeding (edited) ##

Contributors:
`*`editor

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * publication\_id
  * publisher\_id
  * `*`**conference title**
  * **conference location**
  * **conference dates**
  * end\_page (should equal number of pages; so displayLabel=Pages)
  * copyright\_holder
  * abstract
  * date (I've noticed that some conference proceedings are published later than the actual conference - do we need to call out the publication date separately?)

## Conference presentation ##
wondering if we should actually label this just presentation? So it could take in a variety of presentations and lectures. It would still essentially be the same as conference poster except that we would want the display labels to be slightly different as noted below.

Contributors:
author

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * `*`**conference title** - displayLabel="Presentation Venue"?
  * **conference location** - displayLabel="Location"
  * **conference dates** - displayLabel="Date"
  * copyright\_holder (automatically same as author - yes)
  * abstract

## Book review ##

Contributors:
`*`reviewer

(otherwise same as journal article - yes)

## Artwork ##

Per MLA Handbook: "state the artist's name first, when available. In general, italicize the title and then list the date of composition (if the year is unknown, write N.d.) Indicate the medium of composition. Name the institution that houses the work (e.g., a museum), or, for a work in a private collection, give the name of the collection (Collection of...), and then provide the name of the city where the institution or collection is located. If the collector is unknown or wishes to be anonymous, use Private collection without a city name."

Contributors:
`*`artist, curator (yes - there seems to be places where faculty are serving as curators rather than the artist)

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * date
  * `*`**medium** (photograph, print, sculpture, etc)
  * `*`**current location** (gallery, museum, private collection, etc)
  * **city where located**
  * links (for digital artwork)

## Thesis/Dissertation ##

Contributors:
`*`author, advisor, committee chair, committee member, research chair (these are the four that we're calling out in our ETD implementation)

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * end\_page (pagecount - yes)
  * `*`**degree level**
  * `*`**discipline**
  * `*`**institution name** - could this be the same as publisher but with a displayLabel="Granting institution"
  * abstract
  * `*`degree date - this could the same as date but with a displayLabel="Degree Date"

## Patent ##

Contributors:
`*`patent owner

  * `*`title\_primary
  * `*`**filing date**
  * **issue date**
  * `*`**patent number**

## Web page ##

Contributors:
`*`(corporate?) author - do we call out corporate authors separately? or do these need to be treated as publishers?

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * `*`**url**
  * `*`**date of last visit** (default to today)

## Exhibition ##

Contributors:
`*`artist, curator

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * `*`date
  * `*`**venue**
  * **venue location**

## Performance ##

Contributors:

  * Personal: director, conductor, actor, musician, dancer, costume designer, lighting designer, choreographer, composer, etc.
  * Corporate: company, orchestra (or other instrumental ensemble), choir, band

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * **performance title** (if the performance is part of a larger whole)
  * start\_date
  * **end\_date**
  * **venue**
  * **venue location**

## Composition ##

Contributors:
`*`composer

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * **instrumentation**
  * publisher\_id
  * publication\_date

## Recording (sound) ##

Contributors:

  * Corporate: musical ensemble, recording label
  * Individual: musician, performer, interviewer, interviewee

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * publisher\_id
  * publication\_date
  * copyright\_holder
  * identifier (are there identifiers for published sound recordings?)

## Movie ##

Contributors: director, producer, actor (usually these are the only people actually cited, yes?)

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * publication\_date
  * **production company** (corporate contributor?)

## Working paper ##

Contributors: `*`author, editor

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * date
  * **series number**
  * **series name**
  * publisher id - we probably want to include the publishing party (Dept. of Economics, University of Illinois at Urbana-Champaign)

## Tech report ##

(same as working paper)

## Grant ##

Contributors:

  * Corporate: `*`grant agency, institution
  * Individual: PI, other investigator

  * `*`title\_primary
  * title\_secondary
  * title\_tertiary
  * **start date**
  * **end date**
  * `*`**grant number**
  * abstract