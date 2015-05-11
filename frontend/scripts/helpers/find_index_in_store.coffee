_ = require 'lodash'

findIndexInStore = (store, recordOrId) ->
  ids = _.compact if _.isObject(recordOrId) then [recordOrId.id, recordOrId.cid] else [recordOrId]
  state = store.getState()
  _.findIndex state, (record) -> _.includes(ids, record.id) or _.includes(ids, record.cid)

module.exports = findIndexInStore
