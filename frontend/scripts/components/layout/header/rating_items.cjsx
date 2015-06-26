_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
RatingItem = require './rating_item'
Nothing = require '../../shared/nothing'
canEditRating = require '../../../helpers/ratings/can_edit'

{PropTypes} = React
{DragDropContext} = ReactDnd

RatingItems = React.createClass
  displayName: 'RatingItems'

  canEdit: ->
    {user, rating} = @props
    return false unless user.isLoggedIn()
    return false unless rating?.user.id == user.id
    true

  ratingItems: ->
    {user, rating, ratingItems} = @props

    return unless canEditRating user, rating

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

  listenTo: ['ratingItemsStore', 'ratingsStore', 'currentUserStore']

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    user: @app.currentUserStore.get()
    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)

module.exports = DragDropContext(HTML5Backend)(Container)
