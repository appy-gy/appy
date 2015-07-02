_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
isBlank = require '../../helpers/is_blank'
CommentsTree = require './comments_tree'
AuthToComment = require './auth_to_comment'
CommentForm = require '../shared/comments/form'
Nothing = require '../shared/nothing'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    rating: PropTypes.object.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'comments'

  trees: ->
    {comments} = @props

    return if isBlank comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) ->
      <CommentsTree key={tree.root.id} tree={tree} level={1}/>

  commentForm: ->
    {rating} = @props

    return <AuthToComment/> unless rating.canComment

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
    ratingSlug: PropTypes.string.isRequired

  listenTo: ['ratingsStore', 'commentsStore']

  fetch: ->
    {ratingSlug} = @context

    rating: @app.ratingsStore.get(ratingSlug)
    comments: @app.commentsStore.getForRating(ratingSlug)
