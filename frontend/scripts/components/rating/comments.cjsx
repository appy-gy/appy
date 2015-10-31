_ = require 'lodash'
React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingCommentActions = require '../../actions/rating_comments'
isBlank = require '../../helpers/is_blank'
canCommentRating = require '../../helpers/ratings/can_comment'
CommentsTree = require './comments_tree'
AuthToComment = require './auth_to_comment'
CommentForm = require '../shared/comments/form'
CommentTreesBuilder = require '../../helpers/comments/trees_builder'

{PropTypes} = React
{connect} = ReactRedux
{fetchRatingComments} = ratingCommentActions

Comments = React.createClass
  displayName: 'Comments'

  mixins: [PureRenderMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    comments: PropTypes.arrayOf(PropTypes.object).isRequired
    rating: PropTypes.object.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'comments'

  componentWillMount: ->
    @fetchComments()

  canComment: ->
    canCommentRating @props.currentUser, @props.rating

  fetchComments: ->
    @props.dispatch fetchRatingComments(@props.rating.slug)

  trees: ->
    {comments} = @props

    return if isBlank comments

    trees = CommentTreesBuilder.build comments
    trees.map (tree) =>
      <CommentsTree key={tree.root.id} tree={tree} level={1} canComment={@canComment()}/>

  commentForm: ->
    return <AuthToComment/> unless @canComment()

    <CommentForm ref="form"/>

  commentsCounterText: ->
    {comments} = @props

    if comments.length > 0
      "Комментарии (#{comments.length})"
    else
      # TODO: Get random phrases
      'Полно мыслей в голове? Оставь одну тут!'

  render: ->
    {rating} = @props

    <div id="comments" className="comments">
      <div className="comments_header">{@commentsCounterText()}</div>
      <div refCollection="trees" className="comments_trees">
        {@trees()}
      </div>
      {@commentForm()}
    </div>

mapStateToProps = ({currentUser, ratingComments}) ->
  currentUser: currentUser.item
  comments: ratingComments.items

module.exports = connect(mapStateToProps)(Comments)
