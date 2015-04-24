_ = require 'lodash'
TreeNode = require './tree_node'

TreesBuilder =
  build: (comments) ->
    nodes = comments.map (comment) -> new TreeNode comment
    children = _.groupBy nodes, 'root.parentId'
    nodes.each (node) -> node.children = children[node.root.id] || []
    children[null]

module.exports = TreesBuilder
