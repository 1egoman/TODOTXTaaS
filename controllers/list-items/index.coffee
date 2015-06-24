fs = require "fs"
_ = require "underscore"
List = require "../../models/list"

todotxt = (require "jstodotxt").TodoTxt
todos = []

# GET     /items              ->  index
# GET     /items/new          ->  new
# POST    /items              ->  create
# GET     /items/:item       ->  show
# GET     /items/:item/edit  ->  edit
# PUT     /items/:item       ->  update
# DELETE  /items/:item       ->  destroy

# pull out all the functions in the query that mongo cannot deal with
sanitize = (obj) ->
  for k,v of obj
    if typeof v is "function" or k[0] is "_"
      delete obj[k]
  obj

# show all todos in the list
exports.index = (req, res) ->
  List.find (err, data) ->

    res.setHeader "content-type", "application/json"
    res.send
      data: data,
      err: err

exports.new = (req, res) ->
  res.send('new item')

# add new todo item to list
exports.create = (req, res) ->
  item = todotxt.parse req.body.data
  todos.push item

  i = new List sanitize(item[0])
  i.save (err1) ->
    exports.writeChangesToDB todos, (err) ->
      res.send {
        status: "OK",
        method: "create",
        msg: "Added new todo item: #{item}"
        err: err1
      }


# search by project or context
# multiple selectors can be seperated by /s, like
# `/items/@store/glue` -> `glue sticks @store`
exports.show = (req, res) ->
  List.find (err, data) ->
    params = req.url.toLowerCase().split("?")[0].split("/").slice(2)
    matches = exports.select(params, data)

    res.setHeader "content-type", "application/json"
    res.send
      data: matches,
      err: err

exports.edit = (req, res) ->
  res.send('edit item ' + req.params.item)

# update to the body content using selectors
# to pick what to update
#
# not what I wanted, but tough.
exports.update = (req, res) ->
  body = req.body
  delete body._id
  delete body.__v
  if body.complete
    body.date = (new Date()).toString()

  List.update {_id: req.params.id}, body, (err, d) ->
    exports.writeChangesToDB()
    res.send
      data: d
      error: err


exports.destroy = (req, res) ->
  List.delete req.param.item, req.body, (err, d) ->
    exports.writeChangesToDB()
    res.send
      data: d
      error: err

# select a new item from an array of selectors passed
exports.select = (selectors, todos=@todos) ->
  matches = todos

  for selector in selectors
    matches = switch selector[0]

      # search by context
      when "@"
        matches.filter (i) ->
          selector.slice(1) in (i.contexts or [])

      # search by project
      when "+"
        matches.filter (i) ->
          selector.slice(1) in (i.projects or [])

      # search by phrase
      else
        matches.filter (i) ->
          _.intersection(
            selector.split(" "),
            (i.text.toLowerCase().split(' ') or [])
          ).length

  matches

# update database and todo.txt file from local cache
exports.writeChangesToDB = (callback) ->
  List.find (err, todos) ->
    filename = process.env.TODOTXTFILENAME or "todo.txt"

    todos = (t.toObject() for t in todos)

    # render it out
    out = _.map todos, (t) ->
      projects = _.map t.projects or [], (i) -> "+#{i}"
      contexts = _.map t.contexts or [], (i) -> "@#{i}"
      x = t.complete and "x"
      if t.date
        date = new Date(t.date).toISOString().substring(0, 10);
      else
        date = ""

      _.compact([x, date, t.text, projects, contexts]).join " "

    # then, write to file
    fs.writeFile filename, out.join "\n", (err) ->
      callback err if callback

# import the todo.txt file to local cache
exports.populateCache = () ->
  filename = process.env.TODOTXTFILENAME or "todo.txt"
  fs.readFile filename, 'utf8', (err, data) ->
    console.error(err) if err
    todos = todotxt.parse(data)
    # console.log JSON.stringify(todos, null, 2)
