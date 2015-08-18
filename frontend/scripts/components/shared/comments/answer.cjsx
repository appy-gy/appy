React = require 'react/addons'
Form = require './form'
RatingLink = require '../links/rating'
classNames = require 'classnames'

{PropTypes} = React

Answer = React.createClass
  displayName: 'CommentAnswer'

  propTypes:
    inline: PropTypes.bool.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    comment: PropTypes.object.isRequired

  getInitialState: ->
    {router, comment} = @context

    query = router.getCurrentQuery()

    showForm: query.reply and comment.shortId() == query.comment

  triggerForm: ->
    {inline} = @props
    {showForm} = @state

    return unless inline

    @setState showForm: not showForm

  root: ->
    {inline} = @props

    if inline then 'div' else RatingLink

  form: ->
    {showForm} = @state
    {comment} = @context

    return unless showForm

    <Form ref="form" parent={comment} onSubmit={@triggerForm}/>

  render: ->
    {showForm} = @state
    {comment} = @context

    Root = @root()
    classes = classNames 'comment_action', 'm-active': showForm

    <Root className={classes} slug={comment.ratingSlug} query={comment: comment.shortId(), reply: true}>
      <div ref="trigger" className="comment_action-link" onClick={@triggerForm}>
        Ответить
      </div>
      {@form()}
    </Root>

module.exports = Answer
