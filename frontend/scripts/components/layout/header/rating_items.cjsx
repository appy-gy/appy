_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
RatingItem = require './rating_item'
Nothing = require '../../shared/nothing'

{PropTypes} = React
{DragDropContext} = ReactDnd

RatingItems = React.createClass
  displayName: 'RatingItems'

  ratingItems: ->
    {ratingItems, rating} = @props

    return <Nothing/> unless rating.canEdit

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem}/>
      .value()

  render: ->
    <div className="header_rating-items">
      {@ratingItems()}
    </div>

Container = Marty.createContainer RatingItems,
  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: ['ratingItemsStore', 'ratingsStore']

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)

module.exports = DragDropContext(HTML5Backend)(Container)
