_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
UpdateStatus = require './update_status'
Header = require './header'
Description = require './description'
RatingItem = require './rating_item'
AddRatingItem = require './add_rating_item'
Source = require './source'
Like = require './like'
ShareButtons = require './share_buttons'
Nothing = require '../shared/nothing'
UserLink = require '../shared/links/user'
isClient = require '../../helpers/is_client'
isBlank = require '../../helpers/is_blank'

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
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  getChildContext: ->
    {rating, ratingItems} = @props

    { rating, ratingItems }

  componentWillMount: ->
    {rating} = @props

    @app.ratingsActions.view rating.id if rating.status == 'published'

  createRatingItem: ->
    {rating} = @props

    @app.ratingItemsActions.create rating.id

  addRatingItemButton: ->
    {ratingItems} = @props
    {canEdit} = @context

    return unless canEdit

    position = (_.max(ratingItems, 'position')?.position || 0) + 1

    <AddRatingItem className="rating_new-item-button-wrapper" position={position}>
      <div className="rating_new-item-button" >
        <div className="rating_new-item-button-icon"></div>
        <div className="rating_new-item-button-text">Добавить новый пункт в рейтинг</div>
      </div>
    </AddRatingItem>

  authorLink: ->
    {rating} = @props

    return unless rating.status == 'published'

    <div className="rating_author-wrap">
      <UserLink ref="authorLink" user={rating.user} className="rating_author">
        {rating.user.name || rating.user.email}
      </UserLink>
    </div>

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

  source: ->
    {rating} = @props

    <Source/> unless isBlank(rating.source) and rating.status == 'published'

  render: ->
    {rating} = @props

    edit = rating.status != 'published'

    <article className="rating">
      <UpdateStatus/>
      <Header/>
      <Description object={rating} actions="ratingsActions" edit={edit} placeholder="Введите описание рейтинга"/>
      {@authorLink()}
      {@ratingItems()}
      {@addRatingItemButton()}
      {@source()}
      {@likeButton()}
      {@shareButtons()}
    </article>

module.exports = Marty.createContainer Rating,
  propTypes:
    ratingSlug: PropTypes.string.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  listenTo: ['ratingsStore', 'ratingItemsStore']

  fetch: ->
    {ratingSlug} = @props

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
    rating.status == 'published'
