_ = require 'lodash'
uuid = require 'uuid'

getStore = require '../frontend/scripts/helpers/get_store'

class Context
  constructor: ->
    @uuid = uuid.v4()
    @stores = {}

  store: (path, data) ->
    @stores[path] = data

  withFilledStores: (fn) ->
    @fillStores()
    result = fn()
    @clearStores()
    result

  fillStores: ->
    _.each @stores, (data, path) ->
      store = getStore path
      store.preload data

  clearStores: ->
    _.each @stores, (_, path) ->
      store = getStore path
      store.clear()

module.exports = Context
