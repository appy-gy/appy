_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
CommentsTree = require './comments_tree'
CommentForm = require './comment_form'
CommentsStore = require '../../stores/comments'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  trees: ->
    {comments} = @props

    return if _.isEmpty comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) ->
      <CommentsTree key={tree.root.id} tree={tree} level={1}/>

  render: ->
    <div className="comments">
      <div className="comments_header">
        Комментарии
      </div>
      {@trees()}
      <CommentForm/>
    </div>

module.exports = Marty.createContainer Comments,
  contextTypes:
    rating: PropTypes.object.isRequired

  listenTo: CommentsStore

  fetch: ->
    {rating} = @context

    comments: CommentsStore.for(@).getForRating(rating.id)
