mongoose = require "mongoose"

s = mongoose.Schema
  text: String
  priority: Array
  complete: Boolean
  completed: Boolean
  date: String
  contexts: Array
  projects: Array

module.exports = mongoose.model 'list', s
