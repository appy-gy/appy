React = require 'react/addons'
Marty = require 'marty'
Textarea = require 'react-textarea-autosize'
CommentActionCreators = require '../../../action_creators/comments'
CurrentUserStore = require '../../../stores/current_user'

{PropTypes} = React

Form = React.createClass
  displayName: 'CommentForm'

  propTypes:
    parent: PropTypes.object

  contextTypes:
    ratingId: PropTypes.string.isRequired

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
    {ratingId} = @context

    CommentActionCreators.create ratingId, { body, parentId: parent?.id }
      .then => @setState body: ''

  render: ->
    {user} = @props
    {body} = @state

    <div className="comment-form">
      <img className="comment_userface" src={user.avatarUrl 'small'}/>
      <Textarea className="comment_textarea" placeholder={@placeholder} value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
    </div>

module.exports = Marty.createContainer Form,
  listenTo: CurrentUserStore

  fetch: ->
    user: CurrentUserStore.for(@).get()
