_ = require 'lodash'
isClient = require '../../helpers/is_client'

firstLoad = true
storesToSkip = new Set ['currentUser', 'headerSections', 'popups', 'toasts']

ClearStores = (auto = true) ->
  componentWillMount: ->
    return unless auto

    @clearStores()

  clearStores: ->
    console.log 'In progress: clear stores'
    # return unless app? and isClient()
    # return firstLoad = false if firstLoad
    #
    # _.each app.getAllStores(), (store, name) ->
    #   store.clear() unless storesToSkip.has name.replace(/Store$/, '')
    #   true

  clearStoresOnce: ->
    console.log 'In progress: clear stores once'
    # return if @clearedStores
    #
    # @clearedStores = true
    # @clearStores()

module.exports = ClearStores
