_ = require 'lodash'
moment = require 'moment'

sortTrees = (trees) ->
  _.sortBy trees, ({root}) ->
    moment(root.createdAt).unix()

module.exports = sortTrees
