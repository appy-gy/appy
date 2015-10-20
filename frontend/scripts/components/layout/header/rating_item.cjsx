_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'

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

  render: ->
    {ratingItem, sectionColor, width, ratingItemVisibleId} = @props
    classes = classNames 'header_rating-item', "m-visible-full": ratingItemVisibleId == ratingItem.id

    <div className={classes}>
      <div className="header_rating-item-content">
        <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
          {ratingItem.title}
        </a>
        <div className="header_rating-item-options">
          {ratingItem.mark}
        </div>
      </div>
      <div className="header_rating-item-bar" style={backgroundColor: sectionColor, width: "#{width}%"}>
      </div>
    </div>

mapStateToProps = ({ratingItems}, {ratingItem}) ->
  ratingItemVisibleId = ratingItems.waypoint
  { ratingItemVisibleId }

module.exports = connect(mapStateToProps)(RatingItem)
