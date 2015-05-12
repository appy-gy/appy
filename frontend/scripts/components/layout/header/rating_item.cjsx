_ = require 'lodash'
React = require 'react/addons'
ReactDnd = require 'react-dnd'
findInStore = require '../../../helpers/find_in_store'
RatingItemActionCreators = require '../../../action_creators/rating_items'
RatingItemsStore = require '../../../stores/rating_items'

{DragDropMixin} = ReactDnd

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [DragDropMixin]

  propTypes:
    ratingItem: PropTypes.object.isRequired

  statics:
    configureDragDrop: (register) ->
      register 'RatingItem',
        dragSource:
          beginDrag: (component) ->
            item: { ratingItemId: component.props.ratingItem.id }
        dropTarget:
          acceptDrop: (component, {ratingItemId}) ->
            component.updatePosition ratingItemId

  move: (direction) ->
    {ratingItem} = @props

    change = if direction == 'up' then -1 else 1
    newPosition = ratingItem.position + change
    RatingItemActionCreators.updatePosition ratingItem.id, newPosition

  updatePosition: (ratingItemId) ->
    {ratingItem} = @props

    newPosition = findInStore(RatingItemsStore, ratingItemId).position
    RatingItemActionCreators.updatePosition ratingItem.id, newPosition

  render: ->
    {ratingItem} = @props

    <div className="header_rating-item" {...@dragSourceFor('RatingItem')} {...@dropTargetFor('RatingItem')}>
      <div className="header_rating-item-title">
        {ratingItem.title}
      </div>
      <div className="header_rating-item-options">
        <div className="header_rating-item-up" onClick={_.partial @move, 'up'}></div>
        <div className="header_rating-item-down" onClick={_.partial @move, 'down'}></div>
      </div>
    </div>

module.exports = RatingItem
