## Introduction ##

Author authority control requires [a lot of hard work](https://mail2.cni.org/Lists/CNI-ANNOUNCE/Message/113246.html).

So who wrote what?

### Citation Example ###

Dong, Liang, Jiang, Hongrui. (2007). Autonomous microfluidics with stimuli-responsive hydrogels. Soft Matter, 3(10), 1223-1230.

From this Citation, we know these truths:

  * NameStrings: "Dong, Liang" (role: author) and "Jiang, Hongrui" (role: author)
  * Co-Authorship: "Dong, Liang" and "Jiang, Hongrui" wrote this article together
  * Year: "2007"
  * Publication: "Soft Matter"
  * Title keywords: "microfluidics" and "stimuli"

### BibApp's Author Authority Workflow ###

I'll use myself as an example:

User name: Eric William Larson

I login to the BibApp for the first time and the website asks me to select all the NameStrings I have published under throughout my career.  I type in my last name to filter the NameString index.  Here's what I see:

Potential NameString variants:

  * Larson, D
  * ---
  * Larson, E
  * Larson, EW
  * Larson, E.W.
  * Larson, Eric W.
  * Larson, Eric WM.
  * Larson, Eric William
  * ---
  * Larson, F

Maybe all the `Larson, E*` NameStrings are correct (hypothetically, I have published under all these name variants), so I select the check-box next to each NameString to create a new PenName association record, tying my Person record (Person 1: Eric William Larson) to each NameString.  Lastly, I select one of these variants as my "preferred" PenName: Larson, E.W. (ETA: 0.9)

Now I have created 6 PenNames for myself (Person 1: Eric William Larson).  Anytime a new Citation is entered into the BibApp for any of those NameStrings `Larson, E*`, the BibApp will automatically create an Contributorship row creating the association between the new Citation and me (Person: Eric William Larson).

## It's not _that_ simple! ##

The above example works great if no one else "claims" one of my selected PenNames.  When Erica Larson (Person 2: Erica Larson) enters the application and selects "Larson, E" as one of her PenNames, what should we do?

Every Contributorship row, associating a Person to a Citation needs to have a "status" and "score" attribute.

Status options: "calculated", "verified", "denied"
Score: integer representing "how certain we feel the record is valid"

Now to handle Erica's case:

  1. Create Contributorship rows associating Erica (Person 2) to all "Larson, E" NameString related Citations.
  1. For each Contributorship record above set the Contributorship.status attribute to "calculated"

Now two people claiming the "Larson, E" NameString have Contributorship records for some Citations... this could be correct if the same NameString appeared twice in the citation (probably unlikely).

## Who's the real author? ##

Contributorship "status" and "score" help us clean up the mess.  In the BibApp, there are three ways to create Contributorship records:

  1. Generic citation batch import (no Person associated)
  1. Targeted citation batch import (imported for a Person | ETA 0.8)
  1. Single citation insert (add for a Person)

If we're adding a targeted batch import or a single citation via a web form, we're simultaneously verifying the Contributorship record connecting the Person to the Citation.

If we're generically adding citations to application, we need to start (smartly) guessing who the real author is.  Take a look at the flow chart below.  This picture illustrates our plans for machine scoring the authorships we batch import:

### First stab at Algorithm ###

Based on four data fields:
  * Yearspan (range between year of first and last verified authorships)
  * Publication (just the publication title, not publisher?)
  * Verified Co-Authorships
  * Verified Keywords

Calculate contributorships.score in the following way. Get all verified citations for person. For each citation, calculate the score using the following algorithm:

| **Field**  | **Maximum Score** | **Scoring Algorithm** |
|:-----------|:------------------|:----------------------|
| Yearspan | 25 points | If matches = 25 pts |
| Publication | 25 points | If matches = 25 pts |
| Co-authors | 25 points | `(25/total) * matching`  where 'total' is count of number of co-authors in citation, and 'matching' is the # that match |
| Keywords | 25 points | `(25/total) * matching`  where 'total' is count of number of keywords in citation, and 'matching' is the # that match |
| _Total_ | 100 points | Add scores above for total.  Verified citations are then used to calculate the score of other un-verified citations. |

### Author Disambiguation / Authorship Assignment Flow Chart ###

[![](http://www.gliffy.com/pubdoc/1371131/M.jpg)](http://www.gliffy.com/publish/1371131/)