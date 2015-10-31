_ = require 'lodash'
orders = require './orders'

sortRatingItems = (items, order) ->
  {field, dir} = _.find orders, ({type}) -> type == order
  _.sortByOrder items, field, dir

module.exports = sortRatingItems
