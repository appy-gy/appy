_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
RatingItem = require './rating_item'

{PropTypes} = React

RatingItems = React.createClass
  displayName: 'RatingItems'

  ratingItems: ->
    {ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    <div className="header_rating-items">
      {@ratingItems()}
    </div>

module.exports = Marty.createContainer RatingItems,
  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: 'ratingItemsStore'

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
