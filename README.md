TODOTXTaaS
===

My Hack Upstate Idea

Basically, write an app to fix the dropbox syncing problem of todo.txt.
The idea is to write a service that has standard CRUD operations for each item, and integrates well
with todo.txt projects and contexts. Also, there probably should be a frontend of some sort for the
whole thing, ala bootstrap.

Reference: https://github.com/ginatrapani/todo.txt-cli/wiki/The-Todo.txt-Format

### GET /items
Outputs the full todo.txt file.
```
GET /items

(A) Thank Mom for the meatballs @phone
(B) Schedule Goodwill pickup +GarageSale @phone
Post signs around the neighborhood +GarageSale
@GroceryStore Eskimo pies
```

### GET /items/:selector
Outputs all items that match the selector(s). These can take the form of:
  - `@context` - search for all items with a context of `@context`
  - `+project` - search for all items with a project of `+project`
  - `text` - search in the item body for `text` (not case sensitive)

```
GET /items/@phone

(A) Thank Mom for the meatballs @phone
(B) Schedule Goodwill pickup +GarageSale @phone


GET /items/@phone/mom

(A) Thank Mom for the meatballs @phone
```

### POST /items
Adds a new item. The request body should contain the list item in todo.txt format.

```
POST /items
@GroceryStore milk

{
  "status": "OK",
  "method": "create",
  "msg": "Added new todo item: @GroceryStore milk"
}
```

### PUT /items/:selector
Updates all items that match the selector(s). These can take the form of:
  - `@context` - search for all items with a context of `@context`
  - `+project` - search for all items with a project of `+project`
  - `text` - search in the item body for `text` (not case sensitive)

The request body should contain the list item in todo.txt format to replace
anything items identified by the selectors.

```
GET /items/@phone/mom
(A) Thank Dad for the meatballs @phone

{
  "status": "OK",
  "method": "update",
  "msg": "Updated todo item: Thank Dad for the meatballs @phone"
}
```

### DELETE /items/:selector
  - destroy (Not implemented yet)
