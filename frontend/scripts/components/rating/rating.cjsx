_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Nothing = require '../shared/nothing'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
Like = require './like'
isBlank = require '../../helpers/is_blank'
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

    <div className="rating_new-item-button-wrapper">
      <div className="rating_new-item-button" onClick={@createRatingItem}>
        <div className="rating_new-item-button-icon"></div><div className="rating_new-item-button-text">Добавить новый пункт в рейтинг</div>
      </div>
    </div>

  ratingItems: ->
    {ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem, index) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1}/>
      .value()

  publish: ->
    {rating} = @props

    return unless isBlank publishConditions

    RatingActionCreators.update rating.id, status: 'published'

  publishButton: ->
    {rating} = @props

    return <Nothing/> if rating.status == 'published'

    <h1 onClick={@publish} >Опубликовать</h1>

  publishConditions: ->
    {rating} = @props
    {ratingItems} = @props

    conditions = []

    conditions.push 'добавьте заголовок рейтинга' unless rating.title
    conditions.push 'добавьте описание рейтинга' unless rating.description
    conditions.push 'добавьте хотя бы два рейтинга' if ratingItems.length < 2

    conditions.map (condition) -> <li>{condition}</li>

  publishConditionsList: ->
    <ul>{@publishConditions()}</ul>

  render: ->
    {rating} = @props

    <article className="rating">
      {@publishConditionsList()}
      <Header/>
      <Description object={rating} actionCreator={RatingActionCreators}/>
      <a href="/" className="rating_author">
        {rating.user.name || rating.user.email}
      </a>
      <div className="rating_line"></div>
      {@ratingItems()}
      {@addRatingItemButton()}
      <div className="rating_line"></div>
      {@publishButton()}
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
