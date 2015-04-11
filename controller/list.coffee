todotxt = (require "jsTodoTxt").TodoTxt
List = require "../models/list"
_ = require "underscore"
fs = require "fs"

exports.create = (list, callback) ->
  compiledList = todotxt.parse(list)[0]

  # stuff everthing back into array
  compiledList = {
    "text": compiledList.text,
    "priority": compiledList.priority,
    "complete": compiledList.complete,
    "completed": compiledList.completed,
    "date": compiledList.date,
    "contexts": compiledList.contexts
    "projects": compiledList.projects
  }

  # small issue: cannot put null into an array
  compiledList.projects = [] if not compiledList.projects
  compiledList.contexts = [] if not compiledList.contexts
  compiledList.priority = [] if not compiledList.priority
  compiledList.completed = false if typeof compiledList.completed isnt "boolean"
  compiledList.date = "" if not compiledList.date

  l = new List compiledList

  l.save (err) ->
    callback 
      error: err
      doc: compiledList


cacheToTodoText = () ->
  List.find (e, d) ->
    a = _.map d, (d1) ->

      c = _.map d1.contexts, (c) -> "@#{c}"
      p = _.map d1.projects, (p) -> "@#{p}"

      "#{d1.text or ''} #{c.join(' ')} #{p.join(' ')}".trim()
    fs.writeFile "./todo.txt", a.join '\n', (err) ->
      console.log err if err

# read operation
# exports.read = (selectors, callback) ->
#   List.find (err, elems) ->
#     exports.select elems, selectors, (matches) ->
#       callback matches

exports.read = (id, callback) ->
  cacheToTodoText()
  if id
    List.find {_id: id}, (e, r) ->
      callback(e, r)
  else
    List.find callback

# # update operation
# exports.update = (selectors, compiledList, callback) ->
#   projects = []
#   contexts = []

#   # sort projects and contexts
#   selectors.forEach (s) ->
#     projects.push s.slice(1) if s[0] is "+"
#     contexts.push s.slice(1) if s[0] is "@"

#   # remove un-needed elements
#   sl = 
#     projects: projects
#     contexts: contexts

#   # do the update
#   List.update sl, compiledList, (err, data) ->
#     callback data

exports.update = (id, compiledList, callback) ->
  # do the update
  List.update {_id: id}, compiledList, (err, data) ->
    cacheToTodoText()
    callback data


exports.delete = (id, compiledList, callback) ->
  # do the update
  List.delete {_id: id}, compiledList, (err, data) ->
    cacheToTodoText()
    callback data


# select lists by specifing "selectors"
# matches => all lists
# selectors => selectors to start with
exports.select = (matches, selectors, callback) ->

  for selector in selectors
    matches = switch selector[0]

      # search by context
      when "@"
        matches.filter (i) ->
          j = i.toObject()
          selector.slice(1) in (j.contexts or [])

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

  callback matches

