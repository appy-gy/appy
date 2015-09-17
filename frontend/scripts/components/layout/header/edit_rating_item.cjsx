_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReactDnd = require 'react-dnd'
classNames = require 'classnames'
ratingItemActions = require '../../../actions/rating_items'

{PropTypes} = React
{connect} = ReactRedux
{DragSource, DropTarget} = ReactDnd
{changeRatingItemPosition, updateRatingItemPositions} = ratingItemActions

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

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired
    connectDragSource: PropTypes.func.isRequired
    connectDropTarget: PropTypes.func.isRequired
    isDragging: PropTypes.bool.isRequired

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  changePosition: (position) ->
    @props.dispatch changeRatingItemPosition(@props.ratingItem.id, position)

  updatePositions: ->
    @props.dispatch updateRatingItemPositions()

  render: ->
    {ratingItem, index, connectDragSource, connectDropTarget, isDragging} = @props

    classes = classNames 'header_rating-item', 'm-edit', 'm-dragging': isDragging

    connectDropTarget connectDragSource <a href={@ratingItemAnchor()} className={classes} data-scroll>
      <div className="header_rating-item-title">
        {index}. {ratingItem.title}
      </div>
    </a>

module.exports = connect()(DropTarget('EditRatingItem', ratingItemTarget, collectTarget)(DragSource('EditRatingItem', ratingItemSource, collectSource)(EditRatingItem))
)
