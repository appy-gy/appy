_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
Like = require './like'
ShareButtons = require './share_buttons'
RatingMenu = require './menu'
UserLink = require '../shared/links/user'
DeleteRating = require '../shared/ratings/delete'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React

Rating = React.createClass
  displayName: 'Rating'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    canEdit: PropTypes.bool.isRequired

  childContextTypes:
    rating: PropTypes.object.isRequired

  getChildContext: ->
    {rating} = @props

    { rating }

  createRatingItem: ->
    {rating} = @props

    @app.ratingItemsActions.create rating.id

  redirectToProfile: ->
    {router} = @context
    {slug} = @app.currentUserStore.getState()

    router.replaceWith 'user', userSlug: slug

  addRatingItemButton: ->
    {rating} = @props
    {canEdit} = @context

    return unless canEdit

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

    return unless isBlank @publishConditions()

    @app.ratingsActions.update(rating.id, status: 'published')

  publishButton: ->
    {rating} = @props

    return if rating.status == 'published'

    <h1 onClick={@publish}>Опубликовать</h1>

  publishConditions: ->
    {rating} = @props
    {ratingItems} = @props

    conditions = []

    conditions.push 'добавьте заголовок рейтинга' unless rating.title
    conditions.push 'добавьте описание рейтинга' unless rating.description
    conditions.push 'добавьте хотя бы два рейтинга' if ratingItems.length < 2

    conditions.map (condition) -> <div className="rating_menu-notification-list-item">{condition}</div>

  notificationCounter: ->
    return if @publishConditions().length == 0
    counter = "+#{@publishConditions().length}"

    <div className="rating_menu-notification-icon-counter">{counter}</div>

  render: ->
    {rating} = @props

    <article className="rating">
      <RatingMenu>
        <div className="rating_menu-notification">
          <div className="rating_menu-notification-icon">{@notificationCounter()}</div>
          <div className="rating_menu-notification-list">{@publishConditions()}</div>
        </div>
      </RatingMenu>

      <Header/>
      <DeleteRating rating={rating} onDelete={@redirectToProfile}/>
      <Description object={rating} actions="ratingsActions"/>
      <UserLink user={rating.user} className="rating_author">
        {rating.user.name || rating.user.email}
      </UserLink>
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

  listenTo: ['ratingsStore', 'ratingItemsStore']

  fetch: ->
    {ratingSlug} = @context

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
