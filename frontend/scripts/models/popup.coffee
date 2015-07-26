_ = require 'lodash'
uuid = require 'node-uuid'

class Popup
  constructor: (data = {}) ->
    _.merge @, data
    @cid = uuid.v4()

module.exports = Popup
