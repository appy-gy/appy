_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
isBlank = require '../../helpers/is_blank'
isClient = require '../../helpers/is_client'
UpdateStatus = require './update_status'
Header = require './header'
Description = require './description'
RatingItems = require './rating_items'
AddRatingItem = require './add_rating_item'
Source = require './source'
Like = require './like'
ShareButtons = require './share_buttons'
UserLink = require '../shared/links/user'

{PropTypes} = React
{connect} = ReactRedux
{viewRating} = ratingActions
{createRatingItem} = ratingItemActions

Rating = React.createClass
  displayName: 'Rating'

  mixins: [PureRendexMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    canEdit: PropTypes.bool.isRequired

  componentWillMount: ->
    @props.dispatch viewRating() if isClient()

  createRatingItem: ->
    @props.dispatch createRatingItem()

  addRatingItemButton: ->
    {ratingItems, canEdit} = @props

    return unless canEdit

    position = (_.max(ratingItems, 'position')?.position || 0) + 1

    <AddRatingItem className="rating_new-item-button-wrapper" ratingItems={ratingItems} position={position}>
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

    <Like rating={rating}/>

  shareButtons: ->
    {rating} = @props

    return unless rating.status == 'published'

    <ShareButtons/>

  source: ->
    {rating} = @props

    return if isBlank(rating.source) and rating.status == 'published'

    <Source rating={rating}/>

  render: ->
    {rating, ratingItems, canEdit} = @props

    edit = rating.status != 'published'

    <article className="rating">
      <UpdateStatus/>
      <Header rating={rating}/>
      <Description object={rating} objectType="rating" passObjectId={false} edit={edit} placeholder="Нажмите, чтобы ввести описание рейтинга."/>
      {@authorLink()}
      <RatingItems rating={rating} ratingItems={ratingItems} canEdit={canEdit}/>
      {@addRatingItemButton()}
      {@source()}
      {@likeButton()}
      {@shareButtons()}
    </article>

module.exports = connect()(Rating)
