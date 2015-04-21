<<<<<<< HEAD
todotxt = (require "jsTodoTxt").TodoTxt
=======
>>>>>>> 7e5a4f6827dd87cefbceaeb4f69419c83bebaf3d
mongoose = require "mongoose"

s = mongoose.Schema
  text: String
  priority: Array
  complete: Boolean
  completed: Boolean
  date: String
  contexts: Array
  projects: Array

<<<<<<< HEAD
module.exports = mongoose.model 'list', s
=======
module.exports = mongoose.model 'list', s
>>>>>>> 7e5a4f6827dd87cefbceaeb4f69419c83bebaf3d
