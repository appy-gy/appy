_ = require 'lodash'
uuid = require 'node-uuid'
isClient = require '../helpers/is_client'

if isClient()
  app = require '../app'

class Popup
  constructor: (data = {}) ->
    _.merge @, data
    @cid = uuid.v4()

  close: ->
    app.popupsStore.remove @
    @onClose?()

module.exports = Popup
