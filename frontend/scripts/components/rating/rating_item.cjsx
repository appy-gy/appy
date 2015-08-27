React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'
AddRatingItem = require './add_rating_item'
Waypoint = require 'react-waypoint'

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
      Добавить пункт
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

    <section id="item-#{ratingItem.position}" className="rating-item">
      <Waypoint onEnter={@handleWaypointEnter} onLeave={@handleWaypointLeave} threshold={0}/>
      {@addRatingItemButton 'top'}
      <div className="rating-item_header">
        <span className="rating-item_number">{index}</span>
        <Title object={ratingItem} actions="ratingItemsActions" placeholder="Введите заголовок пункта" minFontSize={20} maxFontSize={36}/>
      </div>
      <div className="rating-item_cover-wrap">
        <Image/>
      </div>
      <div className="rating-item_description-wrapper">
        <Description object={ratingItem} actions="ratingItemsActions" placeholder="Введите описание пункта"/>
      </div>
      {@addRatingItemButton 'bottom'}
      {@removeButton()}
      {@votes()}
    </section>

module.exports = RatingItem
