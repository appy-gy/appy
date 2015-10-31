React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
shortId = require '../../../helpers/short_id'
RatingLink = require '../links/rating'

{PropTypes} = React

Open = React.createClass
  displayName: 'CommentOpen'

  mixins: [PureRenderMixin]

  propTypes:
    comment: PropTypes.object.isRequired

  render: ->
    {comment} = @props

    <RatingLink className="comment_action" title="Перейти" rating={comment.rating} query={comment: shortId(comment.id)}>
      <div className="comment_action-link m-show"></div>
    </RatingLink>

module.exports = Open
