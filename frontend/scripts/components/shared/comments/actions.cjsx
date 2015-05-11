React = require 'react/addons'
Form = require './form'

{PropTypes} = React

Actions = React.createClass
  displayName: 'CommentActions'

  contextTypes:
    comment: PropTypes.object.isRequired

  getInitialState: ->
    showForm: false

  triggerForm: ->
    {showForm} = @state

    @setState showForm: not showForm

  form: ->
    {showForm} = @state
    {comment} = @context

    return unless showForm

    <Form parent={comment}/>

  render: ->
    <div className="comment_actions">
      <div className="comment_action" onClick={@triggerForm}>
        Ответить
      </div>
      {@form()}
    </div>

module.exports = Actions
