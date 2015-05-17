React = require 'react/addons'
Actions = require './actions'
UserLink = require '../links/user'

{PropTypes} = React

Comment = React.createClass
  displayName: 'Comment'

  propTypes:
    comment: PropTypes.object.isRequired
    actionTypes: PropTypes.object.isRequired

  childContextTypes:
    comment: PropTypes.object.isRequired

  getChildContext: ->
    {comment} = @props

    { comment }

  getDefaultProps: ->
    inlineForm: false

  render: ->
    {comment, actionTypes} = @props

    <div className="comment">
      <UserLink className="comment_username" user={comment.user}>
        <img className="comment_userface" src={comment.user.avatarUrl('small')}/>
      </UserLink>
      <div className="comment_content">
        <UserLink className="comment_username" user={comment.user}>
          {comment.user.name}
        </UserLink>
        <span className="comment_text">
          {comment.body}
        </span>
        <div className="comment_date">
          {comment.createdAt.fromNow()}
        </div>
        <Actions types={actionTypes}/>
      </div>
    </div>

module.exports = Comment
