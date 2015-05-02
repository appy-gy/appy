_ = require 'lodash'
React = require 'react/addons'
RatingItemActionCreators = require '../../../action_creators/rating_items'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired

  move: (direction) ->
    {ratingItem} = @props

    change = if direction == 'up' then -1 else 1
    newPosition = ratingItem.position + change
    RatingItemActionCreators.updatePosition ratingItem.id, newPosition

  render: ->
    {ratingItem} = @props

    <div className="header_rating-item">
      <div className="header_rating-item-title">
        {ratingItem.title}
      </div>
      <div className="header_rating-item-up" onClick={_.partial @move, 'up'}>up</div>
      <div className="header_rating-item-down" onClick={_.partial @move, 'down'}>down</div>
    </div>

module.exports = RatingItem
