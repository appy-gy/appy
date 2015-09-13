_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
UpdateStatus = require './update_status'
Header = require './header'
Description = require './description'
RatingItems = require './rating_items'
AddRatingItem = require './add_rating_item'
Source = require './source'
Like = require './like'
ShareButtons = require './share_buttons'
Nothing = require '../shared/nothing'
UserLink = require '../shared/links/user'
isClient = require '../../helpers/is_client'
isBlank = require '../../helpers/is_blank'

{PropTypes} = React
{connect} = ReactRedux
{viewRating} = ratingActions
{createRatingItem} = ratingItemActions

Rating = React.createClass
  displayName: 'Rating'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    canEdit: PropTypes.bool.isRequired

  componentWillMount: ->
    @props.dispatch viewRating()

  createRatingItem: ->
    @props.dispatch createRatingItem()

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

  source: ->
    {rating} = @props

    <Source/> unless isBlank(rating.source) and rating.status == 'published'

  render: ->
    {rating} = @context

    edit = rating.status != 'published'

    <article className="rating">
    </article>
      # <UpdateStatus/>
      # <Header/>
      # <Description object={rating} actions="ratingsActions" edit={edit} placeholder="Введите описание рейтинга"/>
      # {@authorLink()}
      # <RatingItems/>
      # {@addRatingItemButton()}
      # {@source()}
      # {@likeButton()}
      # {@shareButtons()}

module.exports = connect()(Rating)
  # propTypes:
  #   ratingSlug: PropTypes.string.isRequired
  #
  # contextTypes:
  #   router: PropTypes.func.isRequired
  #   canEdit: PropTypes.bool.isRequired
  #
  # listenTo: ['ratingsStore', 'ratingItemsStore']
  #
  # fetch: ->
  #   {ratingSlug} = @props
  #
  #   rating: @app.ratingsStore.get(ratingSlug)
  #   ratingItems: @app.ratingItemsStore.getForRating(ratingSlug)
  #
  # done: (results) ->
  #   {router} = @context
  #
  #   if @hasAccess results
  #     return <Rating ref="innerComponent" {...@props} {...results} app={@app}/>
  #
  #   if isClient()
  #     setImmediate -> router.replaceWith 'root'
  #
  #   <Nothing ref="innerComponent"/>
  #
  # hasAccess: ({rating}) ->
  #   {canEdit} = @context
  #
  #   rating.status == 'published' or canEdit
