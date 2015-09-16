_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'

{PropTypes} = React
{connect} = ReactRedux

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired
    visibility: PropTypes.string

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, visibility, isRatingItemVisible} = @props
    classes = classNames 'header_rating-item', ("m-visible-#{visibility}" if visibility?), 'm-enter-waypoint': isRatingItemVisible

    <div className={classes}>
      <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
        {ratingItem.title}
      </a>
      <div className="header_rating-item-options">
        {ratingItem.mark}
      </div>
    </div>

mapStateToProps = ({ratingItems}, {ratingItem}) ->
  visibility = ratingItems.visibilities[ratingItem.id]
  isRatingItemVisible = _.includes(ratingItems.waypoints, ratingItem.id)

  { visibility, isRatingItemVisible }

module.exports = connect(mapStateToProps)(RatingItem)
