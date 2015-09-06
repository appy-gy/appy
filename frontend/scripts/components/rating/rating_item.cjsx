React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'
AddRatingItem = require './add_rating_item'
Waypoint = require '../shared/waypoint'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired

  contextTypes:
    canEdit: PropTypes.bool.isRequired
    rating: PropTypes.object.isRequired

  childContextTypes:
    ratingItem: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingItem} = @props

    { ratingItem, block: 'rating-item' }

  removeItem: ->
    {ratingItem} = @props

    @app.ratingItemsActions.remove ratingItem.id

  handleWaypointEnter: ->
    {ratingItem} = @props

    @app.waypointsActions.append ratingItem

  handleWaypointLeave: ->
    {ratingItem} = @props

    @app.waypointsActions.remove ratingItem

  addRatingItemButton: (place) ->
    {ratingItem} = @props
    {canEdit} = @context

    return unless canEdit

    position = if place == 'top' then ratingItem.position else ratingItem.position + 1

    <AddRatingItem className="rating-item_add-item m-#{place}" position={position}>
      <div className="rating-item_add-item-icon"></div>
      <div className="rating-item_add-item-text">Добавить новый пункт рейтинга между двумя пунктами</div>
    </AddRatingItem>

  removeButton: ->
    {canEdit} = @context

    return unless canEdit

    <div className="rating-item_remove" onClick={@removeItem}></div>

  votes: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Votes/>

  render: ->
    {ratingItem, index} = @props
    {rating} = @context

    edit = rating.status != 'published'

    <Waypoint onEnter={@handleWaypointEnter} onLeave={@handleWaypointLeave}>
      <section id="item-#{ratingItem.position}" className="rating-item">
        <div className="rating-item_add-item-wrap m-top">
          {@addRatingItemButton 'top'}
        </div>
        <div className="rating-item_header">
          <span className="rating-item_number">{index}</span>
          <Title object={ratingItem} actions="ratingItemsActions" edit={edit} placeholder="Введите заголовок пункта"/>
        </div>
        <div className="rating-item_description-wrapper">
          <Description object={ratingItem} actions="ratingItemsActions" edit={edit} placeholder="Введите описание пункта"/>
        </div>
        <div className="rating-item_cover-wrap">
          <Image/>
        </div>
        <div className="rating-item_add-item-wrap m-bottom">
          {@addRatingItemButton 'bottom'}
        </div>
        {@removeButton()}
        {@votes()}
      </section>
    </Waypoint>

module.exports = RatingItem
