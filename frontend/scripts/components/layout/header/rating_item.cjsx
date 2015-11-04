_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ScrollTo = require '../../mixins/scroll_to'

{PropTypes} = React
{connect} = ReactRedux

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [PureRendexMixin, ScrollTo]

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired
    width: PropTypes.number
    sectionColor: PropTypes.string
    invertedSectionColor: PropTypes.string

  componentDidUpdate: (prevProps) ->
    return if @props.visibleRatingItemId == prevProps.visibleRatingItemId or not @isActive() or @isVisible()
    @scrollTo()

  isActive: ->
    @props.visibleRatingItemId == @props.ratingItem.id

  isVisible: ->
    node = ReactDOM.findDOMNode @
    parent = node.parentNode
    parent.scrollTop <= node.offsetTop <= parent.scrollTop + parent.offsetHeight

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, index, visibleRatingItemId, width, sectionColor, invertedSectionColor} = @props

    classes = classNames 'header_rating-item', 'm-active': @isActive()
    barColor = if @isActive() then invertedSectionColor else sectionColor
    opacity = width / 100

    <div className={classes}>
      <div className="header_rating-item-content">
        <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
          {index} {ratingItem.title}
        </a>
        <div className="header_rating-item-options">
          {ratingItem.mark}
        </div>
      </div>
      <div className="header_rating-item-bar" style={backgroundColor: barColor, width: "#{width}%", opacity: opacity}>
      </div>
    </div>

mapStateToProps = ({ratingItems}, {ratingItem}) ->
  visibleRatingItemId = ratingItems.waypoint
  { visibleRatingItemId }

module.exports = connect(mapStateToProps)(RatingItem)
