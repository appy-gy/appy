_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ReactDnd = require 'react-dnd'
classNames = require 'classnames'

{PropTypes} = React
{DragSource, DropTarget} = ReactDnd

ratingItemSource =
  beginDrag: (props, monitor, component) ->
    ratingItemId: props.ratingItem.id
    changePosition: component.changePosition
    updatePositions: component.updatePositions

ratingItemTarget =
  hover: (props, monitor) ->
    {ratingItem} = props
    {ratingItemId, changePosition} = monitor.getItem()

    return if ratingItem.id == ratingItemId
    changePosition ratingItem.position

  drop: (props, monitor) ->
    {updatePositions} = monitor.getItem()

    updatePositions()
    return

collectSource = (connect, monitor) ->
  connectDragSource: connect.dragSource()
  isDragging: monitor.isDragging()

collectTarget = (connect) ->
  connectDropTarget: connect.dropTarget()

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    connectDragSource: PropTypes.func.isRequired
    connectDropTarget: PropTypes.func.isRequired
    isDragging: PropTypes.bool.isRequired

  move: (direction) ->
    {ratingItem} = @props

    change = if direction == 'up' then -1 else 1
    newPosition = ratingItem.position + change
    @app.ratingItemsActions.updatePosition ratingItem.id, newPosition

  changePosition: (newPosition) ->
    {ratingItem} = @props

    @app.ratingItemsActions.changePosition ratingItem.id, newPosition

  updatePositions: ->
    {ratingItem} = @props

    @app.ratingsActions.updatePositions ratingItem.ratingId

  render: ->
    {ratingItem, connectDragSource, connectDropTarget, isDragging} = @props

    classes = classNames 'header_rating-item', 'm-dragging': isDragging

    connectDropTarget connectDragSource <div className={classes}>
      <div className="header_rating-item-title">
        {ratingItem.title}
      </div>
      <div className="header_rating-item-options">
        <div className="header_rating-item-up" onClick={_.partial @move, 'up'}></div>
        <div className="header_rating-item-down" onClick={_.partial @move, 'down'}></div>
      </div>
    </div>

module.exports = DropTarget('RatingItem', ratingItemTarget, collectTarget)(DragSource('RatingItem', ratingItemSource, collectSource)(RatingItem))
