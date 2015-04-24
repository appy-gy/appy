_ = require 'lodash'

class TreeNode
  constructor: (@root) ->

  isLeaf: ->
    _.isEmpty @children

module.exports = TreeNode
