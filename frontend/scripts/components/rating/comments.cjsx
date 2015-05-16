_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
CommentsTree = require './comments_tree'
CommentForm = require '../shared/comments/form'
Nothing = require '../shared/nothing'
RatingsStore = require '../../stores/ratings'
CommentsStore = require '../../stores/comments'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    rating: PropTypes.object.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  trees: ->
    {comments} = @props

    return if isBlank comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) ->
      <CommentsTree key={tree.root.id} tree={tree} level={1}/>

  commentForm: ->
    {rating} = @props

    return unless rating.canComment

    <CommentForm/>

  render: ->
    {rating} = @props

    return <Nothing/> unless rating.canSeeComments

    <div className="comments">
      <div className="comments_header">
        Комментарии
      </div>
      {@trees()}
      {@commentForm()}
    </div>

module.exports = Marty.createContainer Comments,
  contextTypes:
    ratingId: PropTypes.string.isRequired

  listenTo: [RatingsStore, CommentsStore]

  fetch: ->
    {ratingId} = @context

    rating: RatingsStore.for(@).get(ratingId)
    comments: CommentsStore.for(@).getForRating(ratingId)
