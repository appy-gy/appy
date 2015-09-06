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

EditRatingItem = React.createClass
  displayName: 'EditRatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired
    connectDragSource: PropTypes.func.isRequired
    connectDropTarget: PropTypes.func.isRequired
    isDragging: PropTypes.bool.isRequired

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  changePosition: (newPosition) ->
    {ratingItem} = @props

    @app.ratingItemsActions.changePosition ratingItem.id, newPosition

  updatePositions: ->
    {ratingItem} = @props

    @app.ratingsActions.updatePositions ratingItem.ratingId

  render: ->
    {ratingItem, index, connectDragSource, connectDropTarget, isDragging} = @props

    classes = classNames 'header_rating-item', 'm-edit', 'm-dragging': isDragging

    connectDropTarget connectDragSource <a href={@ratingItemAnchor()} className={classes} data-scroll>
      <div className="header_rating-item-title">
        {index}. {ratingItem.title}
      </div>
    </a>

module.exports = DropTarget('EditRatingItem', ratingItemTarget, collectTarget)(DragSource('EditRatingItem', ratingItemSource, collectSource)(EditRatingItem))
