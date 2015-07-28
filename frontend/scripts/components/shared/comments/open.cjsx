React = require 'react/addons'
RatingLink = require '../links/rating'

{PropTypes} = React

Open = React.createClass
  displayName: 'CommentOpen'

  contextTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @context

    <RatingLink className="comment_action" slug={comment.ratingSlug} query={comment: comment.shortId()}>
      <div className="comment_action-link">Показать</div>
    </RatingLink>

module.exports = Open
