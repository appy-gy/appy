_ = require 'lodash'
tinycolor = require 'tinycolor2'
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
    sectionColor = _.get rating, 'section.color', '#fff'
    mSectionColor = tinycolor(sectionColor).setAlpha(.5).toString()

    <div className="header_rating-items" style={backgroundColor: mSectionColor}>
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
