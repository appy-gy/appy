_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
RatingItem = require './rating_item'
Nothing = require '../../shared/nothing'

{PropTypes} = React

RatingItems = React.createClass
  displayName: 'RatingItems'

  ratingItems: ->
    {rating, ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    {rating} = @props

    <div className="header_rating-items">
      <a href="#" className="header_rating-title">{rating.title}</a>
      {@ratingItems()}
    </div>

module.exports = Marty.createContainer RatingItems,
  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: ['ratingItemsStore', 'ratingsStore']

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
