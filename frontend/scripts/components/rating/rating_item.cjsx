React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
Title = require './title'
Description = require './description'
Image = require './rating_item_image'
Votes = require './votes'
Waypoint = require '../shared/waypoint'

{PropTypes} = React
{connect} = ReactRedux
{removeRatingItem, changeRatingItemVisibility, addRatingItemWaypount, removeRatingItemWaypount} = ratingItemActions

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

  handleWaypointEnter: ->
    @props.dispatch addRatingItemWaypount(@props.ratingItem.id)

  handleWaypointLeave: ->
    @props.dispatch removeRatingItemWaypount(@props.ratingItem.id)

  handleWaypointVisibilityChange: (visibility) ->
    @props.dispatch changeRatingItemVisibility(@props.ratingItem.id, visibility)

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

    <Waypoint onEnter={@handleWaypointEnter} onLeave={@handleWaypointLeave} onVisibilityChange={@handleWaypointVisibilityChange}>
      <section id="item-#{ratingItem.position}" className={classes}>
        <div className="rating-item_header">
          <span className="rating-item_number">{index}</span>
          <Title object={ratingItem} objectType="ratingItem" passObjectId={true} edit={edit} placeholder="Введите заголовок пункта"/>
        </div>
        <div className="rating-item_description-wrapper">
          <Description object={ratingItem} objectType="ratingItem" passObjectId={true} edit={edit} placeholder="Введите описание пункта"/>
        </div>
        <div className="rating-item_cover-wrap">
          <Image/>
        </div>
        {@removeButton()}
        {@votes()}
      </section>
    </Waypoint>

module.exports = connect()(RatingItem)
