React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Textarea = require '../textarea'

{PropTypes} = React

Form = React.createClass
  displayName: 'CommentForm'

  mixins: [Marty.createAppMixin()]

  propTypes:
    user: PropTypes.object.isRequired
    parent: PropTypes.object
    onSubmit: PropTypes.func

  contextTypes:
    ratingSlug: PropTypes.string.isRequired

  placeholder: 'Нажмите Shift + Enter для отправки. Для перехода на новую строку нажмите Enter'

  getDefaultProps: ->
    parent: null
    onSubmit: ->

  getInitialState: ->
    body: ''

  changeBody: (event) ->
    @setState body: event.target.value

  onKeyDown: (event) ->
    return unless event.shiftKey and event.key == 'Enter'

    event.preventDefault()
    @createComment()

  createComment: ->
    {parent, onSubmit} = @props
    {body} = @state
    {ratingSlug} = @context

    onSubmit()
    @app.commentsActions.create ratingSlug, { body, parentId: parent?.id }
      .then => @setState body: ''

  render: ->
    {user, parent} = @props
    {body} = @state

    classes = classNames 'comment-form', 'm-answer': parent?

    <div className={classes}>
      <img className="comment_userface" src={user.avatarUrl 'small'}/>
      <Textarea ref="bodyInput" className="comment-form_textarea" placeholder={@placeholder} value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
    </div>

module.exports = Marty.createContainer Form,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
