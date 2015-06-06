_ = require 'lodash'
isClient = require '../../helpers/is_client'

firstLoad = true
storesToSkip = new Set ['currentUser', 'headerSections', 'popups', 'toasts']

ClearStores =
  componentWillMount: ->
    return firstLoad = false if firstLoad
    @clearStores()

  clearStores: ->
    _.each @app.__types.Store, (store, name) ->
      store.clear() unless storesToSkip.has name.replace(/Store$/, '')
      true

module.exports = ClearStores
