React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'
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

  removeButton: ->
    {canEdit} = @context

    return unless canEdit

    <div className="rating-item_remove" onClick={@removeItem}>
      Удалить пункт рейтинга
    </div>

  votes: ->
    {rating} = @context

    return unless rating.status == 'published'

    <Votes/>

  render: ->
    {ratingItem, index} = @props

    <section className="rating-item">
      <Waypoint onEnter={@handleWaypointEnter} onLeave={@handleWaypointLeave} threshold={0}/>
      <a name={ratingItem.position}></a>
      <div className="rating-item_header">
        <Title object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <Image/>
      <div className="rating-item_description-wrapper">
        <Description object={ratingItem} actions="ratingItemsActions"/>
      </div>
      <div className="rating_item_button-wrapper">
        {@removeButton()}
      </div>
      {@votes()}
    </section>

module.exports = RatingItem
