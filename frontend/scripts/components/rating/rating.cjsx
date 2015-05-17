_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Nothing = require '../shared/nothing'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
Like = require './like'
ShareButtons = require './share_buttons'
RatingsStore = require '../../stores/ratings'
RatingItemsStore = require '../../stores/rating_items'
RatingActionCreators = require '../../action_creators/ratings'
RatingItemActionCreators = require '../../action_creators/rating_items'

{PropTypes} = React

Rating = React.createClass
  displayName: 'Rating'

  propTypes:
    rating: PropTypes.object.isRequired

  childContextTypes:
    rating: PropTypes.object.isRequired

  getChildContext: ->
    {rating} = @props

    { rating }

  createRatingItem: ->
    {rating} = @props

    RatingItemActionCreators.create rating.id

  addRatingItemButton: ->
    {rating} = @props

    return unless rating.canEdit

    <h1 onClick={@createRatingItem}>New</h1>

  ratingItems: ->
    {ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem, index) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1}/>
      .value()

  render: ->
    {rating} = @props

    <article className="rating">
      <Header/>
      <Description object={rating} actionCreator={RatingActionCreators}/>
      <div className="tags rating_tags">
        <span className="tag rating_tag">фантазия</span>
        <span className="tag rating_tag">девушки</span>
      </div>
      <a href="/" className="rating_author">
        {rating.user.name}
      </a>
      {@addRatingItemButton()}
      <div className="rating_line"></div>
      {@ratingItems()}
      <div className="rating_line"></div>
      <Like/>
      <ShareButtons/>
    </article>

module.exports = Marty.createContainer Rating,
  contextTypes:
    ratingSlug: PropTypes.string.isRequired

  listenTo: [RatingsStore, RatingItemsStore]

  fetch: ->
    {ratingSlug} = @context

    rating: RatingsStore.for(@).get(ratingSlug)
    ratingItems: RatingItemsStore.for(@).getForRating(ratingSlug)
