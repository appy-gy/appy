React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'
Waypoint = require '../shared/waypoint'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired
    mods: PropTypes.arrayOf(PropTypes.string)

  contextTypes:
    rating: PropTypes.object.isRequired

  childContextTypes:
    ratingItem: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getDefaultProps: ->
    mods: []

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

  handleWaypointVisibilityChange: (visibility) ->
    {ratingItem} = @props

    @app.waypointsActions.change ratingItem, { waypointVisibilityClass: "m-waypoint-#{visibility}" }

  removeButton: ->
    {rating} = @context

    return if rating.status == 'published'

    <div className="rating-item_remove" onClick={@removeItem}></div>

  votes: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Votes/>

  render: ->
    {ratingItem, index, mods} = @props
    {rating} = @context

    edit = rating.status != 'published'
    classes = classNames 'rating-item', mods.map (mod) -> "m-#{mod}"

    <Waypoint onEnter={@handleWaypointEnter} onLeave={@handleWaypointLeave} onVisibilityChange={@handleWaypointVisibilityChange}>
      <section id="item-#{ratingItem.position}" className={classes}>
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
        {@removeButton()}
        {@votes()}
      </section>
    </Waypoint>

module.exports = RatingItem
