<h1>How to Add and Edit People in BibApp</h1>



This page describes how to add and edit people in BibApp. It assumes that you have already configured your BibApp to be hooked to your campus LDAP (see http://code.google.com/p/bibapp/wiki/Installation#4._Configure_BibApp for more information).

Note that as of the current release (1.01) it is not possible to upload multiple people at once through the user interface.

As you start this process, it is helpful to have:

  * a list of researchers you wish to add (perhaps a departmental site, for example);
  * access to images of these researchers (if you wish to add those); and
  * the groups that the researchers are a part of. You may want to add these groups to BibApp before you begin. See http://code.google.com/p/bibapp/wiki/DocumentationAddGroup.

## Who Can Add People? ##

  * Sitewide administrators
  * Sitewide editors
  * Admins of Groups
  * Editors of Groups

## Who Can Edit People? ##

  * Sitewide administrators
  * Sitewide editors
  * Admins of Groups
  * Editors of Groups
  * Admins of People

## Adding a Person ##

1. Log in to your BibApp installation.

2. You can add people from two locations:

  * Click the Admin tab, then People, then Add a Person (only available to system administrators and editors)
  * Click the People tab, then Add a Person (in the bar under the main tabs)

3. At the New Person screen, you can search your LDAP for the researcher.

> ![http://bibapp.org/wp-content/uploads/2011/01/NewPersonPage.png](http://bibapp.org/wp-content/uploads/2011/01/NewPersonPage.png)

4. The LDAP search will present you with possible matches. You can select the appropriate one, and the directory information will be populated into BibApp.

> ![http://bibapp.org/wp-content/uploads/2011/01/PopulatedNewPersonPage.png](http://bibapp.org/wp-content/uploads/2011/01/PopulatedNewPersonPage.png)

5. Note that depending on how your LDAP and BibApp are configured, you may pull in more or less information. You can add more or change information at this point (such as the Research Profile or to change the Display Name) before saving. Once you have saved this information, you will be directed to the Pen Name page (see below for more information on these sections).

## Editing a Person ##

1. Log in to BibApp.

2. Navigate to the person that you wish to edit. There will be a bar below the tabs with a "Edit this Person link" link.

> ![http://bibapp.org/wp-content/uploads/2011/01/EditPerson.png](http://bibapp.org/wp-content/uploads/2011/01/EditPerson.png)

3. Clicking on this link will allow you to edit their personal information, pen names, groups, photo, and unverified contributorships. See below for more information on these sections.

## Pen Names ##

BibApp automatically creates possible pen names for the person based upon the information gathered via LDAP and entered at the personal information stage. BibApp will also search its database to find any other possible pen names. You can add other pen names if you know them.

> | Note: BibApp's generation of pen names will only be as good as the information fed it; if a researcher publishes under another name (a maiden name, for example), but LDAP only has the researcher listed under a married name, there may not be matches found for the published pen name.|
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

> ![http://bibapp.org/wp-content/uploads/2011/01/PenNames.png](http://bibapp.org/wp-content/uploads/2011/01/PenNames.png)

## Photos ##

On the **Photo** page you can upload a photo if you have one. Once you have browsed to the appropriate file, click the upload file button to upload the photo.

If you need to change a photo, simply upload a new one.

## Groups ##

On the **Groups** page you can add the person to as many groups as necessary. Note that adding a person to a subgroup will automatically give them membership in the parent group. Click the Join Selected Groups button to add the person to the groups.

> ![http://bibapp.org/wp-content/uploads/2011/01/GroupMembership.png](http://bibapp.org/wp-content/uploads/2011/01/GroupMembership.png)

Once you have clicked "Join Selected Groups" and the verification box, you will see the groups that the person is a member of, as well as space to indicate their role and the dates associated with the group. Click Save after adding each role and dates.

> ![http://bibapp.org/wp-content/uploads/2011/01/RoleGroups.png](http://bibapp.org/wp-content/uploads/2011/01/RoleGroups.png)

> | **Note:** As of the current (1.01) release of BibApp, these dates do not have any function. There is a feature request in the Issue queue to add functionality that would make use of these dates, but no indication yet of the priority for this. |
|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

## Unverified Contributions ##

If BibApp has any works that it believes may belong to this person because of a pen name, it will list them here. You can verify or deny contributions one by one or in bulk.

> ![http://bibapp.org/wp-content/uploads/2011/01/UnverifiedContributorships.png](http://bibapp.org/wp-content/uploads/2011/01/UnverifiedContributorships.png)