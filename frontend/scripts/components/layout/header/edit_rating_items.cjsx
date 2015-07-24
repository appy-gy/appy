_ = require 'lodash'
React = require 'react/addons'
RatingItem = require './edit_rating_item'

{PropTypes} = React

EditRatingItems = React.createClass
  displayName: 'EditRatingItems'

  contextTypes:
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems} = @context

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    <div className="header_rating-items">
      {@ratingItems()}
    </div>

module.exports = EditRatingItems
