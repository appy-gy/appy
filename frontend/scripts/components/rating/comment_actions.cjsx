React = require 'react/addons'
CommentForm = require './comment_form'

{PropTypes} = React

CommentActions = React.createClass
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

    <CommentForm parent={comment}/>

  render: ->
    <div className="comment_actions">
      <div className="comment_action" onClick={@triggerForm}>
        Ответить
      </div>
      {@form()}
    </div>

module.exports = CommentActions
