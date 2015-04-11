todotxt = (require "jsTodoTxt").TodoTxt
list = require "../models/list"
_ = require "underscore"

exports.create = (list) ->
  null


# read operation
exports.read = (selectors, callback) ->
  list.find (err, elems) ->
    exports.select elems, selectors, (matches) ->
      callback matches

# update operation
exports.update = (selector, item, callback) ->
  null

exports.delete = (selector, callback) ->
  null


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

