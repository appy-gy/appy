React = require 'react/addons'
Form = require './form'
RatingLink = require '../links/rating'

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

    <Form parent={comment}/>

  render: ->
    {comment} = @context

    Root = @root()

    <Root className="comment_action" slug={comment.ratingSlug} query={comment: comment.shortId(), reply: true}>
      <div className="coment_action-link" onClick={@triggerForm}>
        Ответить
      </div>
      {@form()}
    </Root>

module.exports = Answer
