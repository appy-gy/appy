React = require 'react/addons'
Router = require 'react-router'
Form = require './form'

{PropTypes} = React
{Link} = Router

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

    if inline then 'div' else Link

  form: ->
    {showForm} = @state
    {comment} = @context

    return unless showForm

    <Form parent={comment}/>

  render: ->
    {comment} = @context

    Root = @root()

    <Root className="comment_action" to="rating" params={ratingId: comment.ratingId} onClick={@triggerForm}>
      Ответить
      {@form()}
    </Root>

module.exports = Answer
