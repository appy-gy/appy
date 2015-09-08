React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
isBlank = require '../../../helpers/is_blank'
imageUrl = require '../../../helpers/image_url'
Textarea = require '../inputs/text'

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

  placeholder: 'Нажмите Shift + Enter для отправки комментария. Для перехода на новую строку нажмите Enter'

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

    return if isBlank body

    onSubmit()
    @app.commentsActions.create ratingSlug, { body, parentId: parent?.id }
      .then => @setState body: ''

  render: ->
    {user, parent} = @props
    {body} = @state

    classes = classNames 'comment-form', 'm-answer': parent?
    buttonClasses = classNames 'comment-form_button', 'm-disabled': isBlank(body)

    <div className={classes}>
      <img className="comment_userface" src={imageUrl user.avatar, 'small'}/>
      <Textarea ref="bodyInput" className="comment-form_textarea" placeholder={@placeholder} value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
      <div className={buttonClasses} onClick={@createComment}>Написать</div>
    </div>

module.exports = Marty.createContainer Form,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
