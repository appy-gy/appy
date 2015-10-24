React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
shortId = require '../../../helpers/short_id'
Form = require './form'
RatingLink = require '../links/rating'
ratingCommentActions = require '../../../actions/rating_comments'

{PropTypes} = React
{connect} = ReactRedux
{changeCommentFormVisibility} = ratingCommentActions

Answer = React.createClass
  displayName: 'CommentAnswer'

  propTypes:
    inline: PropTypes.bool.isRequired
    query: PropTypes.object.isRequired

  contextTypes:
    comment: PropTypes.object.isRequired

  componentWillMount: ->
    {query} = @props
    {comment} = @context

    @props.dispatch(changeCommentFormVisibility(comment.id)) if query.reply and shortId(comment.id) == query.comment

  triggerForm: ->
    {inline, visibleCommentForm} = @props
    {comment} = @context

    return unless inline

    value = if comment.id == visibleCommentForm then null else comment.id
    @props.dispatch changeCommentFormVisibility(value)

  root: ->
    {inline} = @props

    if inline then 'div' else RatingLink

  form: ->
    {visibleCommentForm} = @props
    {comment} = @context

    return unless comment.id == visibleCommentForm

    <Form ref="form" parent={comment} onSubmit={@triggerForm}/>

  render: ->
    {visibleCommentForm} = @props
    {comment} = @context

    Root = @root()
    classes = classNames 'comment_action', 'm-active': comment.id == visibleCommentForm

    <Root className={classes} rating={comment.rating} query={comment: shortId(comment.id), reply: true}>
      <div ref="trigger" className="comment_action-link m-reply" onClick={@triggerForm}>
      </div>
      {@form()}
    </Root>

mapStateToProps = ({router, ratingComments}) ->
  query: router.location.query || {}
  visibleCommentForm: ratingComments.visibleCommentForm

module.exports = connect(mapStateToProps)(Answer)
