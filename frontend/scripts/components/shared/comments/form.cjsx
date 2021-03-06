React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingCommentActions = require '../../../actions/rating_comments'
isBlank = require '../../../helpers/is_blank'
imageUrl = require '../../../helpers/image_url'
Textarea = require '../inputs/text'
UserLink = require '../links/user'

{PropTypes} = React
{connect} = ReactRedux
{createRatingComment} = ratingCommentActions

Form = React.createClass
  displayName: 'CommentForm'

  mixins: [PureRenderMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    parent: PropTypes.object
    onSubmit: PropTypes.func

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

  placeholder: ->
    {body} = @state
    placeholderClasses = classNames 'comment-form_placeholder', 'm-disabled': !isBlank(body)

    <div className={placeholderClasses}>
      <span className="comment-form_placeholder-text">
        <span className="comment-form_placeholder-shortcut">Shift + Enter</span> - для отправки комментария. <span className="comment-form_placeholder-shortcut">Enter</span> - для перехода на новую строку
      </span>
    </div>

  createComment: ->
    {dispatch, parent, onSubmit} = @props
    {body} = @state

    return if isBlank body

    onSubmit()
    @setState body: ''
    dispatch createRatingComment(body, parent?.id)

  render: ->
    {currentUser, parent} = @props
    {body} = @state

    classes = classNames 'comment-form', 'm-answer': parent?
    buttonClasses = classNames 'comment-form_button', 'm-disabled': isBlank(body)

    <div className={classes}>
      <UserLink user={currentUser}>
        <img className="comment_userface" src={imageUrl currentUser.avatar, 'small'}/>
      </UserLink>
      <Textarea ref="bodyInput" className="comment-form_textarea" value={body} onChange={@changeBody} onKeyDown={@onKeyDown}/>
      {@placeholder()}
      <div className={buttonClasses} onClick={@createComment}>Написать</div>
    </div>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(Form)
