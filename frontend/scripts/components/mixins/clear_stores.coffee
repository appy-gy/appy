_ = require 'lodash'

if window?
  stores = require.context '../../stores', false, /\.coffee$/

storesToSkip = new Set ['current_user', 'header_sections', 'popups', 'toasts']

storeName = (path) ->
  path.match(/\/(.*?)\./)[1]

ClearStores =
  componentWillMount: ->
    return unless stores?
    stores.keys().each (path) ->
      return if storesToSkip.has storeName(path)
      store = stores path
      store.for(@).clear()

module.exports = ClearStores
