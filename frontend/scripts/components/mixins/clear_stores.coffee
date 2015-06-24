_ = require 'lodash'
isClient = require '../../helpers/is_client'
app = require '../../application' if isClient()

firstLoad = true
storesToSkip = new Set ['currentUser', 'headerSections', 'popups', 'toasts']

ClearStores = (auto = true) ->
  componentWillMount: ->
    return unless auto

    @clearStores()

  clearStores: ->
    return unless app? and isClient()
    return firstLoad = false if firstLoad

    _.each app.getAllStores(), (store, name) ->
      store.clear() unless storesToSkip.has name.replace(/Store$/, '')
      true

  clearStoresOnce: ->
    return if @clearedStores

    @clearedStores = true
    @clearStores()

module.exports = ClearStores
