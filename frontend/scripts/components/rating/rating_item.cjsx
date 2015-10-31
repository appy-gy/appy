React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
Title = require './title'
Description = require './description'
Attachment = require './rating_item_attachment'
Votes = require './votes'
Waypoint = require '../shared/waypoint'

{PropTypes} = React
{connect} = ReactRedux
{removeRatingItem, changeRatingItemWaypoint} = ratingItemActions

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    dispatch: PropTypes.func.isRequired
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

    @props.dispatch removeRatingItem(@props.ratingItem.id)

  handleWaypointChange: ->
    @props.dispatch changeRatingItemWaypoint(@props.ratingItem.id)

  removeButton: ->
    {rating} = @context

    return if rating.status == 'published'

    <div className="rating-item_remove" onClick={@removeItem}></div>

  votes: ->
    <Votes/> if @context.rating.status == 'published'

  render: ->
    {ratingItem, index, mods} = @props
    {rating} = @context

    edit = rating.status != 'published'
    classes = classNames 'rating-item', mods.map (mod) -> "m-#{mod}"

    <Waypoint onChange={@handleWaypointChange}>
      <section id="item-#{ratingItem.position}" className={classes}>
        <div className="rating-item_header">
          <span className="rating-item_number">{index}</span>
          <Title object={ratingItem} objectType="ratingItem" passObjectId={true} edit={edit} placeholder="Введите заголовок пункта"/>
        </div>
        <div className="rating-item_description-wrapper">
          <Description object={ratingItem} objectType="ratingItem" passObjectId={true} edit={edit} placeholder="Введите описание пункта"/>
        </div>
        <Attachment/>
        {@removeButton()}
        {@votes()}
      </section>
    </Waypoint>

module.exports = connect()(RatingItem)
