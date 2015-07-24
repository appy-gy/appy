React = require 'react/addons'
Marty = require 'marty'
Header = require './header'
RatingActions = require './rating_actions'
EditRatingItems = require './edit_rating_items'

{PropTypes} = React

EditRatingHeader = React.createClass
  displayName: 'EditRatingHeader'

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  childContextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {rating, ratingItems} = @props

    { rating, ratingItems, block: 'header' }

  render: ->
    <Header>
      <RatingActions/>
      <EditRatingItems/>
    </Header>

module.exports = Marty.createContainer EditRatingHeader,
  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: ['ratingsStore', 'ratingItemsStore']

  fetch: ->
    {router} = @context
    {ratingSlug} = router.getCurrentParams()

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
