findIndexInStore = require './find_index_in_store'

findInStore = (store, recordOrId) ->
  index = findIndexInStore store, recordOrId
  store.getState()[index]

module.exports = findInStore
