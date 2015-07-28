_ = require 'lodash'
findIndexInArray = require './find_index_in_array'

findInStore = (array, data, opts) ->
  index = findIndexInArray array, data, opts
  return array[index] unless _.isArray index
  _.at array, index

module.exports = findInStore
