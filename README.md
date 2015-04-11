TODOTXTaaS
===

My Hack Upstate Idea

Basically, write an app to fix the dropbox syncing problem of todo.txt. 
The idea is to write a service that has standard CRUD operations for each item, and integrates well
with todo.txt projects and contexts. Also, there probably should be a frontend of some sort for the 
whole thing, ala bootstrap.

Reference: https://github.com/ginatrapani/todo.txt-cli/wiki/The-Todo.txt-Format


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