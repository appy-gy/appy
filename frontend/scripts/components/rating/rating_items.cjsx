_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
sortRatingItems = require '../../helpers/rating_items/sort'
RatingItem = require './rating_item'
AddRatingItem = require './add_rating_item'

{PropTypes} = React
{connect} = ReactRedux

RatingItems = React.createClass
  displayName: 'RatingItems'

  propTypes:
    order: PropTypes.string.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  getInitialState: ->
    hoveredButtonPosition: null

  changeHoveredButtonPosition: (position) ->
    @setState hoveredButtonPosition: position

  addRatingItemButton: (ratingItem) ->
    {rating} = @context

    return if rating.status == 'published'

    onEnter = _.partial @changeHoveredButtonPosition, ratingItem.position
    onLeave = _.partial @changeHoveredButtonPosition, null

    <AddRatingItem key="add-item-#{ratingItem.id}" className="rating_add-item-wrap" position={ratingItem.position} onMouseEnter={onEnter} onMouseLeave={onLeave}>
      <div className="rating_add-item">
        <div className="rating_add-item-icon"></div>
        <div className="rating_add-item-text">Добавить новый пункт рейтинга между двумя пунктами</div>
      </div>
    </AddRatingItem>

  content: ->
    {order} = @props
    {hoveredButtonPosition} = @state
    {ratingItems} = @context

    _ sortRatingItems(ratingItems, order)
      .map (ratingItem, index) =>
        mods = []
        mods.push 'shift-top' if ratingItem.position == hoveredButtonPosition - 1
        mods.push 'shift-bottom' if ratingItem.position == hoveredButtonPosition

        [
          @addRatingItemButton ratingItem
          <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1} mods={mods}/>
        ]
      .flatten()
      .value()

  render: ->
    <div className="rating_items">
      {@content()}
    </div>

mapStateToProps = ({ratingItems}) ->
  order: ratingItems.order

module.exports = connect(mapStateToProps)(RatingItems)
