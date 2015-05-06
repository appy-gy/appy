uuid = require 'node-uuid'

class Toast
  constructor: (@content) ->
    @cid = uuid.v4()

module.exports = Toast
