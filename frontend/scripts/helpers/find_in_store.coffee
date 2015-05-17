_ = require 'lodash'
findIndexInStore = require './find_index_in_store'

findInStore = (store, data, opts) ->
  index = findIndexInStore store, data, opts
  state = store.getState()
  return state[index] unless _.isArray index
  _.at state, index

module.exports = findInStore
