_ = require 'lodash'
uuid = require 'uuid'

getStorage = require '../frontend/scripts/helpers/get_storage'

class Context
  constructor: ->
    @uuid = uuid.v4()
    @storages = {}

  store: (path, data) ->
    @storages[path] = data

  withFilledStorages: (fn) ->
    @fillStorages()
    result = fn()
    @clearStorages()
    result

  fillStorages: ->
    _.each @storages, (data, path) ->
      storage = getStorage path
      storage.preload data

  clearStorages: ->
    _.each @storages, (_, path) ->
      storage = getStorage path
      storage.clear()

module.exports = Context
