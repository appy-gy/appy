_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
SectionsSelect = require './sections_select'
TagsSelect = require './tags_select'
RatingItem = require './rating_item'
Comments = require './comments'
Meta = require '../shared/ratings/meta'
RatingsStore = require '../../stores/ratings'
RatingItemsStore = require '../../stores/rating_items'
RatingActionCreators = require '../../action_creators/ratings'
RatingItemsActionCreator = require '../../action_creators/rating_items'

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

  newRatingItem: ->
    {ratingId} = @props

    RatingItemsActionCreator.new(ratingId)

  ratingItems: ->
    {ratingItems} = @props

    ratingItems.map (ratingItem) ->
      <RatingItem key={ratingItem.id || ratingItem.cid} ratingItem={ratingItem}/>

  rating: ->
    {rating} = @props

    <div>
      <header className="rating_header">
        <Meta rating={rating} block="rating"/>
        <div className="image-selector">
          <div className="image-selector_icon"></div>
          <div className="image-select_text">Загрузить изображение</div>
        </div>
        <SectionsSelect object={rating} actionCreator={RatingActionCreators}/>
        <TagsSelect/>
        <Title object={rating} actionCreator={RatingActionCreators}/>
      </header>
      <Description object={rating} actionCreator={RatingActionCreators}/>
      <div className="tags rating_tags">
        <span className="tag rating_tag">фантазия</span>
        <span className="tag rating_tag">девушки</span>
      </div>
      <a href="/" className="rating_author">
        {rating.user.name}
      </a>
      <h1 onClick={@newRatingItem}>New</h1>
      <div className="rating_line"></div>
      {@ratingItems()}
      <div className="rating_line"></div>
      <div className="rating-like">
        <div className="rating-like_burst-1"></div>
        <div className="rating-like_burst-2"></div>
        <div className="rating-like_content ion-thumbsup"></div>
      </div>
      <div className="rating-share">
        <div className="rating-share_button facebook">
          <div className="rating-share_icon ion-social-facebook"></div>
          <div className="rating-share_text">Нравится</div>
        </div>
        <div className="rating-share_button vk">
          <div className="rating-share_icon"></div>
          <div className="rating-share_text">Поделиться</div>
        </div>
        <div className="rating-share_button twitter">
          <div className="rating-share_icon ion-social-twitter"></div>
          <div className="rating-share_text">Твитнуть</div>
        </div>
      </div>
    </div>

  render: ->
    <article className="rating">
      {@rating()}
    </article>

module.exports = Marty.createContainer Rating,
  listenTo: [RatingsStore, RatingItemsStore]

  fetch: ->
    {ratingId} = @props

    rating: RatingsStore.for(@).get ratingId
    ratingItems: RatingItemsStore.for(@).getForRating(ratingId)
