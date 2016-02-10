_ = require 'lodash'
orders = require './orders'

sortRatingItems = (items, order) ->
  {field, dir} = _.find orders, ({type}) -> type == order
  _.orderBy items, [field, orders[0].field], [dir, orders[0].dir]

module.exports = sortRatingItems
