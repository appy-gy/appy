React = require 'react/addons'
UserLink = require '../shared/links/user'

{PropTypes} = React

Comment = React.createClass
  displayName: 'Comment'

  propTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @props

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
      </div>
    </div>

module.exports = Comment
