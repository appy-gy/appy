_ = require 'lodash'
TreeNode = require './tree_node'

TreesBuilder =
  build: (comments) ->
    nodes = comments.map (comment) -> new TreeNode comment
    children = _.groupBy nodes, (node) -> node.root.parentId || 'root'
    nodes.each (node) -> node.children = children[node.root.id] || []
    children.root

module.exports = TreesBuilder
