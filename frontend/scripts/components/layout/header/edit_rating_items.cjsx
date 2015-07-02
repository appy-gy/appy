_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
RatingItem = require './edit_rating_item'
Nothing = require '../../shared/nothing'

{PropTypes} = React
{DragDropContext} = ReactDnd

EditRatingItems = React.createClass
  displayName: 'EditRatingItems'

  ratingItems: ->
    {rating, ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    <div className="header_rating-items">
      {@ratingItems()}
    </div>

module.exports = Marty.createContainer EditRatingItems,
  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: ['ratingItemsStore', 'ratingsStore']

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
