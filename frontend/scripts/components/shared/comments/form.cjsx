React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingCommentActions = require '../../../actions/rating_comments'
isBlank = require '../../../helpers/is_blank'
imageUrl = require '../../../helpers/image_url'
Textarea = require '../inputs/text'

{PropTypes} = React
{connect} = ReactRedux
{createRatingComment} = ratingCommentActions

Form = React.createClass
  displayName: 'CommentForm'

  propTypes:
    dispatch: PropTypes.func.isRequired
    parent: PropTypes.object
    onSubmit: PropTypes.func

  contextTypes:
    currentUser: PropTypes.object.isRequired

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
    {dispatch, parent, onSubmit} = @props
    {body} = @state

    return if isBlank body

    onSubmit()
    @setState body: ''
    dispatch createRatingComment(body, parent?.id)

  render: ->
    {parent} = @props
    {body} = @state
    {currentUser} = @context

    classes = classNames 'comment-form', 'm-answer': parent?
    buttonClasses = classNames 'comment-form_button', 'm-disabled': isBlank(body)

    <div className={classes}>
      <img className="comment_userface" src={imageUrl currentUser.avatar, 'small'}/>
      <Textarea ref="bodyInput" className="comment-form_textarea" placeholder={@placeholder} value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
      <div className={buttonClasses} onClick={@createComment}>Написать</div>
    </div>

module.exports = connect()(Form)
