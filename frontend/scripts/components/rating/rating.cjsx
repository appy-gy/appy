_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
UpdateStatus = require './update_status'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
Like = require './like'
ShareButtons = require './share_buttons'
Nothing = require '../shared/nothing'
UserLink = require '../shared/links/user'
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

  addRatingItemButton: ->
    {rating} = @props
    {canEdit} = @context

    return unless canEdit

    <div className="rating_new-item-button-wrapper">
      <div className="rating_new-item-button" onClick={@createRatingItem}>
        <div className="rating_new-item-button-icon"></div>
        <div className="rating_new-item-button-text">Добавить новый пункт в рейтинг</div>
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

  render: ->
    {rating} = @props

    <article className="rating">
      <UpdateStatus/>
      <Header/>
      <Description object={rating} actions="ratingsActions" placeholder="Введите описание рейтинга"/>
      {@authorLink()}
      {@ratingItems()}
      {@addRatingItemButton()}
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
