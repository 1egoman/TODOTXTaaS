fs = require "fs"
app = (require "express")()
bodyParser = require "body-parser"
app.use(bodyParser.json());

# connect to db
mongoose = require "mongoose"
host = process.env.DB or "mongodb://dev:dev@ds061751.mongolab.com:61751/todotxtaas"

mongoose.connect host
mongoose.connection.on('error', console.error.bind(console, 'db error:'))
mongoose.connection.once 'open', () ->
  console.log("Connected To Mongo instance:", host)

app.use require("express-static")(__dirname+"/www")

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
