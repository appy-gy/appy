React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

Open = React.createClass
  displayName: 'CommentOpen'

  contextTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @context

    <Link className="comment_action" to="rating" params={ratingId: comment.ratingId}>
      Показать
    </Link>

module.exports = Open
