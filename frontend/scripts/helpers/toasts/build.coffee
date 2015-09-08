_ = require 'lodash'
uuid = require 'node-uuid'

defaultOptions =
  type: 'success'
  timeout: 10000

buildToast = (content, options = {}) ->
  _.defaults { content, cid: uuid.v4() }, options, defaultOptions

module.exports = buildToast
