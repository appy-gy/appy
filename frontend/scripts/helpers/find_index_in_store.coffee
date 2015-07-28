findIndexInArray = require './find_index_in_array'

findIndexInStore = (store, data, opts) ->
  findIndexInArray store.getState(), data, opts

module.exports = findIndexInStore
