React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

Comment = React.createClass
  displayName: 'Comment'

  propTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @props

    <div className="comment">
      <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
      <div className="comment_content">
        <Link className="comment_username" to="user" params={userId: comment.user.id}>
          {comment.user.name}
        </Link>
        <span className="comment_text">
          {comment.body}
        </span>
        <div className="comment_date">
          {comment.createdAt.fromNow()}
        </div>
      </div>
    </div>

module.exports = Comment
