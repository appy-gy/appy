_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
Image = require './rating_item_image'
Video = require './rating_item_video'

{PropTypes} = React

RatingItemAttachment = React.createClass
  displayName: 'RatingItemAttachment'

  mixins: [PureRendexMixin]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  image: ->
    {ratingItem, canEdit} = @props

    <Image ratingItem={ratingItem} canEdit={canEdit}/> if _.isEmpty ratingItem.video

  video: ->
    {ratingItem, canEdit} = @props

    <Video ratingItem={ratingItem} canEdit={canEdit}/> unless ratingItem.image?

  render: ->
    <div className="rating-item_attachment">
      {@image()}
      {@video()}
    </div>

module.exports = RatingItemAttachment
