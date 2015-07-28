findInArray = require './find_in_array'

findInStore = (store, data, opts) ->
  findInArray store.getState(), data, opts

module.exports = findInStore
