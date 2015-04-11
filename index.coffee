app = (require "express")()
list = require "./controller/list"
todotxt = (require "jsTodoTxt").TodoTxt

bodyparser = require "body-parser"
app.use bodyparser.json()

# connect to db
mongoose = require "mongoose"
host = process.env.DB or "mongodb://dev:dev@ds061751.mongolab.com:61751/todotxtaas"

mongoose.connect host
mongoose.connection.on('error', console.error.bind(console, 'db error:'))
mongoose.connection.once 'open', () ->
  console.log("Connected To Mongo instance:", host)


### CREATE ###

# get all lists items
app.post "/list/:query", (req, res) ->
  list.create req.params.query, (err) ->
    res.send err


### READING ###

# get all lists items
app.get "/lists.json", (req, res) ->
  list.read [], (matches) ->
    res.send matches

# get list items by selector
app.get /lists\/[a-zA-Z0-9\+\@\/]*/gi, (req, res) ->
  selectors = req.url.slice(7, -5).split "/"

  list.read selectors, (matches) ->
    res.send matches

### UPDATE ###

app.put "/lists.json", (req, res) ->
  list.update [], req.body, (err) ->
    res.send
      error: err

app.put /lists\/[a-zA-Z0-9\+\@\/]*/gi, (req, res) ->
  selectors = req.url.slice(7, -5).split "/"
  list.update selectors, req.body, (err) ->
    res.send
      error: err


console.log "-> :#{process.env.PORT or 8000}"
app.listen process.env.PORT or 8000






