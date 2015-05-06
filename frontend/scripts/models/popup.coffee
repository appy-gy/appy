uuid = require 'node-uuid'

class Popup
  constructor: (@content) ->
    @cid = uuid.v4()

module.exports = Popup
