_ = require 'lodash'

idFields = ['id', 'cid', 'slug']

extractIds = (obj) ->
  _(obj).pick(idFields).values().compact().value()

findIndexInStore = (store, data) ->
  return unless data?
  ids = _ if _.isObject(data) then extractIds(data) else [data]
  state = store.getState()
  _.findIndex state, (record) -> not ids.intersection(extractIds(record)).isEmpty()

module.exports = findIndexInStore
