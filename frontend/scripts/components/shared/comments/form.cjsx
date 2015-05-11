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

  getDefaultProps: ->
    parent: null

  getInitialState: ->
    body: ''

  changeBody: (event) ->
    @setState body: event.target.value

  onKeyDown: (event) ->
    return if event.key != 'Enter' or event.shiftKey

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
      <Textarea className="comment_textarea" value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
    </div>

module.exports = Marty.createContainer Form,
  listenTo: CurrentUserStore

  fetch: ->
    user: CurrentUserStore.for(@).get()
