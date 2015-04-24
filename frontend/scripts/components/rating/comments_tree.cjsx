React = require 'react/addons'
classNames = require 'classnames'
Comment = require './comment'

{PropTypes} = React

CommentsTree = React.createClass
  displayName: 'CommentsTree'

  propTypes:
    tree: PropTypes.object.isRequired
    level: PropTypes.number.isRequired

  subtrees: ->
    {tree, level} = @props

    return if tree.isLeaf()

    tree.children.map (subtree) ->
      <CommentsTree key={subtree.root.id} tree={subtree} level={level + 1}/>

  render: ->
    {tree, level} = @props

    classes = classNames 'comments_tree', "m-level-#{level}", 'm-subtree': level > 1

    <div className={classes}>
      <Comment comment={tree.root}/>
      {@subtrees()}
    </div>

module.exports = CommentsTree
