_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
canCommentRating = require '../../helpers/ratings/can_comment'
CommentsTree = require './comments_tree'
NoComments = require './no_comments'
AuthToComment = require './auth_to_comment'
CommentForm = require '../shared/comments/form'
Nothing = require '../shared/nothing'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    user: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  childContextTypes:
    canComment: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    canComment: @canComment(), block: 'comments'

  canComment: ->
    {user, rating} = @props

    canCommentRating user, rating

  trees: ->
    {comments} = @props

    return <NoComments/> if isBlank comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) ->
      <CommentsTree key={tree.root.id} tree={tree} level={1}/>

  commentForm: ->
    {user, rating} = @props

    return <AuthToComment/> unless @canComment()

    <CommentForm ref="form"/>

  render: ->
    {rating} = @props

    return <Nothing/> unless rating.canSeeComments

    <div className="comments">
      <div className="comments_header">
        Комментарии
      </div>
      <div refCollection="trees" className="comments_trees">
        {@trees()}
      </div>
      {@commentForm()}
    </div>

module.exports = Marty.createContainer Comments,
  contextTypes:
    ratingSlug: PropTypes.string.isRequired

  listenTo: ['currentUserStore', 'ratingsStore', 'commentsStore']

  fetch: ->
    {ratingSlug} = @context

    user: @app.currentUserStore.get()
    rating: @app.ratingsStore.get(ratingSlug)
    comments: @app.commentsStore.getForRating(ratingSlug)
