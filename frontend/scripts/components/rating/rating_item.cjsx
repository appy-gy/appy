React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
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

  mixins: [PureRendexMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingItem: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired
    index: PropTypes.number.isRequired
    mods: PropTypes.arrayOf(PropTypes.string)

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
    {rating, canEdit} = @props

    return unless canEdit

    <div className="rating-item_remove" onClick={@removeItem}></div>

  votes: ->
    {rating, ratingItem} = @props

    <Votes ratingItem={ratingItem}/> if rating.status == 'published'

  render: ->
    {rating, ratingItem, canEdit, index, mods} = @props

    classes = classNames 'rating-item', mods.map (mod) -> "m-#{mod}"

    <Waypoint onChange={@handleWaypointChange}>
      <section id="item-#{ratingItem.position}" className={classes}>
        <div className="rating-item_header">
          <span className="rating-item_number">{index}</span>
          <Title object={ratingItem} objectType="ratingItem" passObjectId={true} edit={canEdit} placeholder="Введите заголовок пункта"/>
        </div>
        <div className="rating-item_description-wrapper">
          <Description object={ratingItem} objectType="ratingItem" passObjectId={true} edit={canEdit} placeholder="Введите описание пункта"/>
        </div>
        <Attachment ratingItem={ratingItem} canEdit={canEdit}/>
        {@removeButton()}
        {@votes()}
      </section>
    </Waypoint>

module.exports = connect()(RatingItem)
