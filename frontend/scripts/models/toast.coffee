_ = require 'lodash'
uuid = require 'node-uuid'

class Toast
  defaultOptions:
    type: 'success'
    timeout: 10000

  constructor: (@content, options = {}) ->
    @cid = uuid.v4()
    _.defaults @, options, @defaultOptions

module.exports = Toast
