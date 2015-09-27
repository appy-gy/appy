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
    width: PropTypes.string

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, visibility, ratingItemVisibility, sectionColor, width} = @props
    classes = classNames 'header_rating-item', "m-visible-#{ratingItemVisibility}"

    <div className={classes}>
      <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
        {ratingItem.title}
      </a>
      <div className="header_rating-item-options">
        {ratingItem.mark}
      </div>
      <div className="header_rating-item-bar" style={backgroundColor: sectionColor, width: width}>
      </div>
    </div>

mapStateToProps = ({ratingItems}, {ratingItem}) ->
  ratingItemVisibility =  _.result(_.find(ratingItems.waypoints, ratingItem.id), "#{ratingItem.id}.visibility", "hidden")
  { ratingItemVisibility }

module.exports = connect(mapStateToProps)(RatingItem)
