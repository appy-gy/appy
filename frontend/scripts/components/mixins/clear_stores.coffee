_ = require 'lodash'
isClient = require '../../helpers/is_client'

if isClient()
  stores = require.context '../../stores', false, /\.coffee$/

firstLoad = true
storesToSkip = new Set ['current_user', 'header_sections', 'popups', 'toasts']

storeName = (path) ->
  path.match(/\/(.*?)\./)[1]

ClearStores =
  componentWillMount: ->
    return unless stores?
    return firstLoad = false if firstLoad
    stores.keys().each (path) ->
      return if storesToSkip.has storeName(path)
      store = stores path
      store.for(@).clear()

module.exports = ClearStores
