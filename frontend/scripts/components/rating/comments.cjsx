_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingCommentActions = require '../../actions/rating_comments'
isBlank = require '../../helpers/is_blank'
canCommentRating = require '../../helpers/ratings/can_comment'
CommentsTree = require './comments_tree'
NoComments = require './no_comments'
AuthToComment = require './auth_to_comment'
CommentForm = require '../shared/comments/form'
Nothing = require '../shared/nothing'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React
{connect} = ReactRedux
{fetchRatingComments} = ratingCommentActions

Comments = React.createClass
  displayName: 'Comments'

  propTypes:
    dispatch: PropTypes.func.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired

  childContextTypes:
    canComment: PropTypes.bool.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    canComment: @canComment(), block: 'comments'

  componentWillMount: ->
    @fetchComments()

  canComment: ->
    canCommentRating @context.currentUser, @context.rating

  fetchComments: ->
    @props.dispatch fetchRatingComments(@context.rating.slug)

  trees: ->
    {comments} = @props

    return <NoComments/> if isBlank comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) ->
      <CommentsTree key={tree.root.id} tree={tree} level={1}/>

  commentForm: ->
    return <AuthToComment/> unless @canComment()

    <CommentForm ref="form"/>

  render: ->
    {comments} = @props
    {rating} = @context

    <div className="comments">
      <div className="comments_header">
        Комментарии ({comments.length})
      </div>
      <div refCollection="trees" className="comments_trees">
        {@trees()}
      </div>
      {@commentForm()}
    </div>

mapStateToProps = ({ratingComments}) ->
  comments: ratingComments.items

module.exports = connect(mapStateToProps)(Comments)
