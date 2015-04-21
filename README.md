TODOTXTaaS
===

My Hack Upstate Idea

Basically, write an app to fix the dropbox syncing problem of todo.txt.
The idea is to write a service that has standard CRUD operations for each item, and integrates well
with todo.txt projects and contexts. Also, there probably should be a frontend of some sort for the
whole thing, ala bootstrap.

Reference: https://github.com/ginatrapani/todo.txt-cli/wiki/The-Todo.txt-Format

<<<<<<< HEAD

Documentation
===

Create
---
- `POST http://127.0.0.1:8000/list`

Read
---
- `GET http://127.0.0.1:8000/lists.json`
- `GET http://127.0.0.1:8000/lists/@abc.json`
- `GET http://127.0.0.1:8000/lists/@abc/+def.json`

Update
---
(put in body json with parts to update)
- `PUT http://127.0.0.1:8000/lists/@abc.json`
- `PUT http://127.0.0.1:8000/lists/@abc/+def.json`
=======
NOTE: date is only set once items are completed

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

### PUT /items/:id
updates item with the specified id (the `_id`)

### DELETE /items/:id
deletes item with the specified id (the `_id`)

### DELETE /items/:selector
  - destroy (Not implemented yet)
>>>>>>> 7e5a4f6827dd87cefbceaeb4f69419c83bebaf3d
