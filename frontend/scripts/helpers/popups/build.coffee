_ = require 'lodash'
uuid = require 'node-uuid'

buildPopup = (data) ->
  _.merge cid: uuid.v4(), data

module.exports = buildPopup
