# fun_with_clean_architecture

This is a simple to-do list manager app

## A rough list of things this app should do

- add a new item to the to-do list
- mark an item as "done"
- delete or cancel an item that you're not going to do
- sort items in a few ways
  - when added
  - when due
  - priority
- group items by tag, or don't
- persist to-do items between app launches
- tags for items from a user-defined list
- edit an item
  - change its text
  - set or edit due date
  - change tags
  - change priority

## A new list where we show the results of each requirement as use cases

- create a new item with some fields
  - description
  - when due, if wanted
  - priority, if wanted, otherwise a default priority
  - 0 or more tags
- mark item as "done"
- delete item
- get the list of todo items sorted by some factor, filtered by some factor
- get the list of tags
- view one item
- update some fields on an item

Persisting happens, from the user perspective, implicitly, without them needing to worry about it.

## Pick a use case to implement first

Create a new item with some fields

- create an item with all fields provider: description, when due, priority, some tags
- create an item with: description only
- create an item with: description and when due
- item is persisted
- due must be in the future
- priority is set to normal
- create an item with: description and when due and priority
- due must be in the future
- create an item with: description and when due and tags
- create an item with: description and priority and tags
- create an item with: description and one tag
- create an item with: description and several tags
- a description cannot be empty, and must be one word long at least
- due must be in the future
- priority is normal, low, or high
- if no priority is given, it is normal
- tags must be 1 character long
- repeated tags work, but the repetition is not recorded
- if no due date is given, there is no due date
- items are created with a creation timestamp

Note: not doing two use-cases at once (e.g. create + view), as this is a kind of integration test (a very small one). Instead, looking at the inner state of the use case in some way to see that it does as expected.

## Select use cases that we'll use for a full-stack iteration

### features we will be developing this iteration, framed in terms of use cases, and mentioning full layer-cake concerns (ui + persistence etc.)

- create an item with: description only
  - item is persisted
  - a description cannot be empty, and must be one word long at least
  - items are created with a creation timestamp
- get the list of todo items sorted by creation timestamp
  - timestamps need to be persisted in universal time
  - timestamps are displayed in local time
- mark an item as "done"
  - this deletes the item from persistence, doesn't show up in lists any more

### consider UI fat marker concept

see Shape Up from Basecamp

## UI tests

Implementing widget tests

make a specific Widget class for the "UI entities", so that in the tests you
can use `find.byType` to locate that thing, or those things, and the exact
flutter implementation can change as needed, keeping the test the same.

Similarly to the interator & gatewat tests, when implementing the UI, we might want to verify the existence of a widget with a specific type. While this proves such a widget exists, it doesn't prove that it has the expected desired behaviour. This suggests writing extra tests specifically for such a widget, in isolation. For example: is it clickable? when we click it, does it trigger the provided handler? 
