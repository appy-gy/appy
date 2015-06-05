_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ReactDnd = require 'react-dnd'
findInStore = require '../../../helpers/find_in_store'

{PropTypes} = React
{DragSource, DropTarget} = ReactDnd

ratingItemSource =
  beginDrag: (props) ->
    ratingItemId: props.ratingItem.id

ratingItemTarget =
  drop: (props, monitor) ->

collectSource = (connect) ->
  connectDragSource: connect.dragSource()

collectTarget = (connect) ->
  connectDropTarget: connect.dropTarget()

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    connectDragSource: PropTypes.func.isRequired
    connectDropTarget: PropTypes.func.isRequired

  # statics:
  #   configureDragDrop: (register) ->
  #     register 'RatingItem',
  #       dragSource:
  #         beginDrag: (component) ->
  #           item: { ratingItemId: component.props.ratingItem.id }
  #       dropTarget:
  #         acceptDrop: (component, {ratingItemId}) ->
  #           component.updatePosition ratingItemId

  move: (direction) ->
    {ratingItem} = @props

    change = if direction == 'up' then -1 else 1
    newPosition = ratingItem.position + change
    @app.ratingItemsActions.updatePosition ratingItem.id, newPosition

  updatePosition: (ratingItemId) ->
    {ratingItem} = @props

    newPosition = findInStore(@app.ratingItemsStore, ratingItemId).position
    @app.ratingItemsActions.updatePosition ratingItem.id, newPosition

  render: ->
    {ratingItem, connectDragSource, connectDropTarget} = @props

    connectDropTarget connectDragSource <div className="header_rating-item">
      <div className="header_rating-item-title">
        {ratingItem.title}
      </div>
      <div className="header_rating-item-options">
        <div className="header_rating-item-up" onClick={_.partial @move, 'up'}></div>
        <div className="header_rating-item-down" onClick={_.partial @move, 'down'}></div>
      </div>
    </div>

module.exports = DropTarget('RatingItem', ratingItemTarget, collectTarget)(DragSource('RatingItem', ratingItemSource, collectSource)(RatingItem))
