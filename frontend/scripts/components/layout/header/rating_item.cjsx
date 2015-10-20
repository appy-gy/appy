_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
tinycolor = require 'tinycolor2'

{PropTypes} = React
{connect} = ReactRedux

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired
    visibility: PropTypes.string
    sectionColor: PropTypes.string
    width: PropTypes.number

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  invertColor: (color) ->
    rgbaMask = { r: 255, g: 255, b: 255, a: 0 }
    colorRgba = tinycolor(color).toRgb()

    invertedColor = _.transform colorRgba, (result, value, key) ->
      result[key] = rgbaMask[key] - value

    tinycolor(invertedColor).toRgbString()

  render: ->
    {ratingItem, sectionColor, width, ratingItemVisibleId} = @props

    barColor = if ratingItemVisibleId == ratingItem.id then @invertColor(sectionColor) else sectionColor

    <div className="header_rating-item">
      <div className="header_rating-item-content">
        <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
          {ratingItem.title}
        </a>
        <div className="header_rating-item-options">
          {ratingItem.mark}
        </div>
      </div>
      <div className="header_rating-item-bar" style={backgroundColor: barColor, width: "#{width}%"}>
      </div>
    </div>

mapStateToProps = ({ratingItems}, {ratingItem}) ->
  ratingItemVisibleId = ratingItems.waypoint
  { ratingItemVisibleId }

module.exports = connect(mapStateToProps)(RatingItem)
