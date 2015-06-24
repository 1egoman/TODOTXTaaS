<<<<<<< HEAD
app = (require "express")()
list = require "./controller/list"
todotxt = (require "jsTodoTxt").TodoTxt

bodyparser = require "body-parser"
app.use bodyparser.json()
<<<<<<< HEAD
=======
=======
fs = require "fs"
app = (require "express")()
bodyParser = require "body-parser"
app.use(bodyParser.json());
>>>>>>> 7e5a4f6827dd87cefbceaeb4f69419c83bebaf3d
>>>>>>> 0326450fcd833b3b5859903b989ebe6b161c560d

# connect to db
mongoose = require "mongoose"
host = process.env.DB or "mongodb://dev:dev@ds061751.mongolab.com:61751/todotxtaas"

mongoose.connect host
mongoose.connection.on('error', console.error.bind(console, 'db error:'))
mongoose.connection.once 'open', () ->
  console.log("Connected To Mongo instance:", host)

<<<<<<< HEAD
=======
<<<<<<< HEAD

>>>>>>> 0326450fcd833b3b5859903b989ebe6b161c560d
### CREATE ###

# get all lists items
app.post "/list/:query", (req, res) ->
  list.create req.params.query, (err) ->
    res.send err


### READING ###

# get all lists items
app.get "/lists", (req, res) ->
  list.read null, (err, d) ->
    res.send
      data: d,
      err: err

app.get "/lists/:id", (req, res) ->
  list.read req.params.id, (err, d) ->
    res.send
      data: d,
      err: err

# get list items by selector
# app.get /lists\/[a-zA-Z0-9\+\@\/]*/gi, (req, res) ->
#   selectors = req.url.slice(7, -5).split "/"

#   list.read selectors, (matches) ->
#     res.send matches

### UPDATE ###

app.put "/lists/:id", (req, res) ->
  list.update req.params.id, req.body, (err) ->
    res.send
      error: err

### DELETE ###
app.delete /lists\/[a-zA-Z0-9\+\@\/]*/gi, (req, res) ->
  selectors = req.url.slice(7, -5).split "/"
  list.update selectors, req.body, (err) ->
    res.send
      error: err


console.log "-> :#{process.env.PORT or 8000}"
app.listen process.env.PORT or 8000






<<<<<<< HEAD
=======
=======
app.use require("express-static")(__dirname+"/www")

>>>>>>> 0326450fcd833b3b5859903b989ebe6b161c560d
# resources
listItems = require './controllers/list-items'
# listItems.populateCache();
app.get("/items", listItems.index)
# app.get("/items/new", listItems.new)
# app.get("/items/:item/edit", listItems.edit)
app.get("/items/([\w\/\@\+]*)", listItems.show)
app.post("/items", listItems.create)
# app.put("/items/([\w\/\@\+]*)", listItems.update)
app.put("/items/:id", listItems.update)
app.delete("/items/:item", listItems.destroy)

app.get "/todo.txt", (req, res) ->
  fs.readFile "./todo.txt", 'utf8', (err, data) ->
    res.setHeader "content-type", "text/plain"
    res.send data

# listen for server response
app.listen(process.env.PORT || 8005)
<<<<<<< HEAD
=======
>>>>>>> 7e5a4f6827dd87cefbceaeb4f69419c83bebaf3d
>>>>>>> 0326450fcd833b3b5859903b989ebe6b161c560d
