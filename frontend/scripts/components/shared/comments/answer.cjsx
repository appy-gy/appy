React = require 'react/addons'
Form = require './form'
RatingLink = require '../links/rating'

{PropTypes} = React

Answer = React.createClass
  displayName: 'CommentAnswer'

  propTypes:
    inline: PropTypes.bool.isRequired

  contextTypes:
    comment: PropTypes.object.isRequired

  getInitialState: ->
    showForm: false

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

    <Root className="comment_action" slug={comment.ratingSlug} onClick={@triggerForm}>
      Ответить
      {@form()}
    </Root>

module.exports = Answer
