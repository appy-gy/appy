React = require 'react'
shortId = require '../../../helpers/short_id'
RatingLink = require '../links/rating'

{PropTypes} = React

Open = React.createClass
  displayName: 'CommentOpen'

  contextTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @context

    <RatingLink className="comment_action" rating={comment.rating} query={comment: shortId(comment.id)}>
      <div className="comment_action-link m-show"></div>
    </RatingLink>

module.exports = Open
