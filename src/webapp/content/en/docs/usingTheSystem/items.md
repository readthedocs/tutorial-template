---
title: "Items"
description: ""
lead: "Click on the Items tab and the following screen will be displayed:"
date: 2022-10-226T08:48:57+00:00
lastmod: 2022-10-26T08:48:57+00:00
draft: false
images: []
menu:
  docs:
    parent: "usingTheSystem"
weight: 60
toc: true
---

![Alt text](images/gettingStarted/Traxsense-Items-Management.png)

The Item Management page gives a view of all the items in the system filtered depending on the organization the items belong to and offers access to [add](#add-items) and [view](#view-an-item-and-its-history) items can be customized by clicking on the Columns button which will display the following pop up:

![Alt text](images/usingTheSystem/Items/Traxsense-Items-Management-Columns.png)

The User can select the columns they want to see displayed in the table By selecting the tick boxes for the desired columns, the selection will be remembered per user for their current session.

The user can also export the displayed information to a .csv file by clicking on the CSV button or print the displayed information by clicking on the Print button.

## View an Item and its History

### Item Information

![Alt text](images/usingTheSystem/Items/Traxsense-Item-History.png)

The Item History page offers a view of a specific item and also contains historical records of transactions involving the item on the Item Log table as well as any conditions that need to be tracked on the condition log table.

To navigate to the [Edit Item page](#edit-an-item) click the edit button, to view point in time gps information click the item tracking button to view the item tracking page.

To return to the Item Management screen click on the Back button.

### Item Transaction Logs

The Item Transaction Log table is found on the Item History page, this sub-section of the Item History page is shown by default and can be hidden by clicking Hide Transactions:

![Alt text](images/usingTheSystem/Items/Traxsense-Item-Transaction-Log.png)

This table shows a record of all the transaction an Item undergoes, this includes the item being part of a task or tag being read by a reader or gateway. This table allows the user to set a date range to limit the results shown and can give a more specific view of the transactions. The same functionality to customize the columns shown on this page by clicking the columns button is also present on this page.


### Condition Logs 

The condition log table is found on the Item History page, When show conditions is clicked the following sub-section is shown:

![Alt text](images/usingTheSystem/Items/Traxsense-Condition-Log.png)

This table shows a historic record of specific conditions of an item through time, these conditions must be defined [Condition types](../types#item-status) are changed through the rule engine or the completion of tasks.

### Item Tracking

By clicking the Item Tracking button the user is taken to the following page: 

![Alt text](images/usingTheSystem/Items/Traxsense-Item-Tracking.png)

This page gives the user a view of the movements of the item if gps data is present on their transaction history. By default the latest ten gps points are shown but a date range can be given to show the movements of items over a period of time.

## Add Items

Items can be added individually, in bulk, automatically or imported with a csv; for any of these methods a historical [note](#adding-notes) can be added to keep record of any information relating to the registration that may be important.

![Alt text](images/usingTheSystem/Items/Traxsense-Items-Management-Add-Buttons.png)

### Add Single Item

After clicking the single button the user will be taken to the add item page which will have the following default fields: 

![Alt text](images/usingTheSystem/Items/Traxsense-Add-Item.png)

Selecting an Item Type from list of types that are registered, additional fields will show according to the metadata associated with the item type. These additional fields are optional and add more contextual information about the item.

Click on the Save button to complete the item registration or click on the Back button to exit the process discarding the changes made to the form.


### Add Items in Bulk by Scanning

After clicking the bulk button on the item management page the following page is displayed:

![Alt text](images/usingTheSystem/Items/Traxsense-Bulk-Add-Item.png)

The Bulk Add Item page allows users to add multiple items to Traxsense using a reader. After filling choosing a location and filling in the other relevant fields the option to select a reader will appear along with a few additional buttons.

![Alt text](images/usingTheSystem/Items/Traxsense-Bulk-Add-Item-Readers.png)

To start scanning click on the Start Reading button ![Alt text](images/usingTheSystem/Items/Traxsense-Start-Scanning.png), to restart the scanning session click on the reset button ![Alt text](images/usingTheSystem/Items/Traxsense-Reset-Scan.png)  .
To view all the items scanned click on the View List button ![Alt text](images/usingTheSystem/Items/Traxsense-View-List.png)
Click on the Save button to complete the item registration.

#### Add Items by Importing at List

![Alt text](images/usingTheSystem/Items/Traxsense-Item-Importer.png)

The Import CSV textbox, click on the Choose File button , the File Explorer will open, navigate to the file you wish to import, select the file and click on the Open button

To abort the activity, click on the Cancel button

Click on the Save button to complete the item import.
The following message will be displayed:

Click on the Ok button to return to the Item Management screen.

#### Add Items by Automatically during Manufacturing

After clicking the Auto button on the Item Management page, the following page will be displayed:
![Alt text](images/usingTheSystem/Items/Traxsense-Automatic-Registration.png)

The automatic registration feature allows users to set up a portal to automatically register any tags read at the specified portal over a given period of time. The details of the items are filled in on the Automatic Registration page as seen above.

## Edit an Item

Clicking the Edit button on the Item History page brings the user to the following page:

![Alt text](images/usingTheSystem/Items/Traxsense-Edit-Item.png)

Here the item details can be edited, with the option to add a historical [note](#adding-notes) of any relevant additional information about the change of item details. Once the desired changes have been made click on the Save button.

To return to the Item Management screen click on the Back button.

## Delete an Item

To delete/remove an item, click on the Delete button from the Edit Item screen.
The following message box will be displayed:

![Alt text](images/usingTheSystem/Items/Traxsense-Confirm-Delete.png)

Click on Remove Item to complete the item deletion or to abort click on the Go Back button.

## Adding Notes

On the Add Item and Edit Item page there is a toggle called Add Notes:

![Alt text](images/usingTheSystem/Items/Traxsense-Items-Add-Notes.png)

Toggling Add Notes reveals a text area which can be used to add a note to the item to have a point in time record of information associated to a transaction that can be adding/editing an item or carrying out a task ([see tasks](../tasks#view-task-details)).

The notes will be saved along with the other item data when the save button is clicked.

To return to the Item Management screen click on the Back button.
