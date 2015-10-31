_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'

{PropTypes} = React
{connect} = ReactRedux

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired
    ratingItemVisibleId: PropTypes.string.isRequired
    width: PropTypes.number
    sectionColor: PropTypes.string
    invertedSectionColor: PropTypes.string

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, index, ratingItemVisibleId, width, sectionColor, invertedSectionColor} = @props

    barColor = if ratingItemVisibleId == ratingItem.id then invertedSectionColor else sectionColor
    opacity = width / 100

    <div className="header_rating-item">
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
  ratingItemVisibleId = ratingItems.waypoint
  { ratingItemVisibleId }

module.exports = connect(mapStateToProps)(RatingItem)
