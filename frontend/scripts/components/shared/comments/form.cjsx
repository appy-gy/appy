React = require 'react/addons'
Marty = require 'marty'
Textarea = require 'react-textarea-autosize'

{PropTypes} = React

Form = React.createClass
  displayName: 'CommentForm'

  mixins: [Marty.createAppMixin()]

  propTypes:
    parent: PropTypes.object

  contextTypes:
    ratingSlug: PropTypes.string.isRequired

  placeholder: 'Нажмите Shift + Enter для отправки. Для перехода на новую строку нажмите Enter'

  getDefaultProps: ->
    parent: null

  getInitialState: ->
    body: ''

  changeBody: (event) ->
    @setState body: event.target.value

  onKeyDown: (event) ->
    return unless event.shiftKey and event.key == 'Enter'

    event.preventDefault()
    @createComment()

  createComment: ->
    {parent} = @props
    {body} = @state
    {ratingSlug} = @context

    @app.commentsActions.create ratingSlug, { body, parentId: parent?.id }
      .then => @setState body: ''

  render: ->
    {user} = @props
    {body} = @state

    <div className="comment-form">
      <img className="comment_userface" src={user.avatarUrl 'small'}/>
      <Textarea className="comment_textarea" placeholder={@placeholder} value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
    </div>

module.exports = Marty.createContainer Form,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
