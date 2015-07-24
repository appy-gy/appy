_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
Like = require './like'
ShareButtons = require './share_buttons'
RatingMenu = require './menu'
Nothing = require '../shared/nothing'
UserLink = require '../shared/links/user'
Delete = require '../shared/ratings/delete'
prepublishValidation = require '../../helpers/ratings/prepublish_validation'
isClient = require '../../helpers/is_client'

{PropTypes} = React

Rating = React.createClass
  displayName: 'Rating'

  mixins: [Marty.createAppMixin()]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

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

  publish: ->
    {rating} = @props

    return unless _.isEmpty @publishErrors()

    @app.ratingsActions.update(rating.id, status: 'published')

  addRatingItemButton: ->
    {rating} = @props
    {canEdit} = @context

    return unless canEdit

    <div className="rating_new-item-button-wrapper">
      <div className="rating_new-item-button" onClick={@createRatingItem}>
        <div className="rating_new-item-button-icon"></div><div className="rating_new-item-button-text">Добавить новый пункт в рейтинг</div>
      </div>
    </div>

  authorLink: ->
    {rating} = @props

    return unless rating.status == 'published'

    <UserLink ref="authorLink" user={rating.user} className="rating_author">
      {rating.user.name || rating.user.email}
    </UserLink>

  likeButton: ->
    {rating} = @props

    return unless rating.status == 'published'

    <Like ref="likeButton"/>

  shareButtons: ->
    {rating} = @props

    return unless rating.status == 'published'

    <ShareButtons ref="shareButtons"/>

  ratingItems: ->
    {ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem, index) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1}/>
      .value()

  publishButton: ->
    {rating} = @props

    return if rating.status == 'published'

    <h1 ref="publishButton" onClick={@publish}>Опубликовать</h1>

  deleteButton: ->
    {rating} = @props
    {canEdit} = @context

    return if rating.status == 'published'

    <Delete ref="deleteButton" rating={rating} onDelete={@redirectToProfile}/>

  publishErrors: ->
    {rating, ratingItems} = @props

    prepublishValidation rating, ratingItems

  publishErrorItems: ->
    @publishErrors().map (condition) ->
      <div key={condition} className="rating_menu-notification-list-item">
        {condition}publishErrors
      </div>

  publishErrorsCounter: ->
    errors = @publishErrors()
    return if _.isEmpty errors
    counter = "+#{errors.length}"

    <div className="rating_menu-notification-icon-counter">
      {counter}
    </div>

  render: ->
    {rating} = @props

    <article className="rating">
      <Header/>
      {@deleteButton()}
      <Description object={rating} actions="ratingsActions"/>
      {@authorLink()}
      <div className="rating_line"></div>
      {@ratingItems()}
      {@addRatingItemButton()}
      <div className="rating_line"></div>
      {@publishButton()}
      {@likeButton()}
      {@shareButtons()}
    </article>

module.exports = Marty.createContainer Rating,
  contextTypes:
    router: PropTypes.func.isRequired
    canEdit: PropTypes.bool.isRequired
    ratingSlug: PropTypes.string.isRequired

  listenTo: ['ratingsStore', 'ratingItemsStore']

  fetch: ->
    {ratingSlug} = @context

    rating: @app.ratingsStore.get(ratingSlug)
    ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)

  done: (results) ->
    {router} = @context

    if @hasAccess results
      return <Rating ref="innerComponent" {...@props} {...results} app={@app}/>

    if isClient()
      setImmediate -> router.replaceWith 'root'

    <Nothing ref="innerComponent"/>

  hasAccess: ({rating}) ->
    {canEdit} = @context

    rating.status == 'published' or canEdit
