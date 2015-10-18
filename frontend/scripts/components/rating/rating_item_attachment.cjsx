_ = require 'lodash'
React = require 'react'
Image = require './rating_item_image'
Video = require './rating_item_video'

{PropTypes} = React

RatingItemAttachment = React.createClass
  displayName: 'RatingItemAttachment'

  contextTypes:
    ratingItem: PropTypes.object.isRequired

  image: ->
    <Image/> if _.isEmpty @context.ratingItem.video

  video: ->
    <Video/> unless @context.ratingItem.image?

  render: ->
    <div className="rating-item_attachment">
      {@image()}
      {@video()}
    </div>

module.exports = RatingItemAttachment
