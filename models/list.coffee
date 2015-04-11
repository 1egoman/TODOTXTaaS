todotxt = (require "jsTodoTxt").TodoTxt
mongoose = require "mongoose"

s = mongoose.Schema({
  "name": String,
  "desc": String,
  "type": String,
  "id": Number,
  "image": String,
  "tags": Array,
  "ip": {
    "host": String,
    "port": Number
  },
  "data": Object,
  "actions": Array
});

module.exports = mongoose.model 'list', s