_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Item = require './item'
Title = require './title'
Description = require './description'
SectionsSelect = require '../sections/select_all'
Meta = require '../shared/ratings/meta'
RatingsStore = require '../../stores/ratings'
RatingItemsStore = require '../../stores/rating_items'
RatingsActionCreator = require '../../action_creators/ratings'
RatingItemsActionCreator = require '../../action_creators/rating_items'

{PropTypes} = React

Rating = React.createClass
  displayName: 'Rating'

  propTypes:
    rating: PropTypes.object.isRequired

  newRatingItem: ->
    {ratingId} = @props
    RatingItemsActionCreator.new(ratingId)

  items: ->
    {ratingItems, ratingId} = @props

    ratingItems.map (item) -> <Item key={item.id} item={item} ratingId={ratingId}/>

  rating: ->
    {rating} = @props

    <div>
      <header className="rating_header">
        <Meta rating={rating} block="rating"/>
        <div className="image-selector">
          <div className="image-selector_icon"></div>
          <div className="image-select_text">Загрузить изображение</div>
        </div>
        <a href="/" className="rating_section-name">{rating.section.name}</a>
        <SectionsSelect />
        <Title object={rating} actionCreator={RatingsActionCreator} />
      </header>
      <Description object={rating} actionCreator={RatingsActionCreator} />
      <div className="tags rating_tags">
        <span className="tag rating_tag">фантазия</span>
        <span className="tag rating_tag">девушки</span>
      </div>
      <a href="/" className="rating_author">
        {rating.user.name}
      </a>
      <h1 onClick={@newRatingItem}>New</h1>
      <div className="rating_line"></div>
      {@items()}
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
      <div className="comments">
        <div className="comments_header">
          Комментарии
        </div>
        <div className="comment">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <div className="comment_content">
            <span className="comment_username">Роман Оганесян</span>
            <span className="comment_text">Проснувшись однажды утром после беспокойного сна</span>
            <div className="comment_date">28 минут назад</div>
          </div>
        </div>
        <div className="comment">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <div className="comment_content">
            <span className="comment_username">Роман Оганесян</span>
            <span className="comment_text">Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
            <div className="comment_date">28 минут назад</div>
          </div>
        </div>
        <div className="comment">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <div className="comment_content">
            <span className="comment_username">Роман Оганесян</span>
            <span className="comment_text">ПроснувшисьоднаждыПроснувшисьоднаждыутромпослебеспокойногоснаГрегоЗамзадваоывдалодлвыоадПроснувшисьоднаждыутромпослебеспокойного</span>
            <div className="comment_date">28 минут назад</div>
          </div>
        </div>
        <div className="comment">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <div className="comment_content">
            <span className="comment_username">Роман Оганесян</span>
            <span className="comment_text">ПроснувшисьоднаждыутромпослебеспокойногоснаГрегоЗамзадваоывдалодлвыоадПроснувшисьоднаждыутромпослебеспокойного сна,<br/> Грегор Замза дваоывдало<br/><br/> длвыоад Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
            <div className="comment_date">28 минут назад</div>
          </div>
        </div>
        <div className="comment">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <div className="comment_content">
            <span className="comment_username">Роман Оганесян</span>
            <span className="comment_text">Проснувшись однажды утром после беспокойного сна, Грегор Замза дваоывдало длвыоад</span>
            <div className="comment_date">28 минут назад</div>
          </div>
        </div>
        <div className="comment-form">
          <img className="comment_userface" src="https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg"/>
          <textarea className="comment_textarea"></textarea>
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
