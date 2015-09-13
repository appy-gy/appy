_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratingItem: PropTypes.object.isRequired

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, waypoints} = @props
    isRatingVisible = _.includes(waypoints, ratingItem)

    classes = classNames 'header_rating-item', 'm-waypoint-enter': isRatingVisible, ratingItem.waypointVisibilityClass

    <div className={classes}>
      <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
        {ratingItem.title}
      </a>
      <div className="header_rating-item-options">
        {ratingItem.mark}
      </div>
    </div>

module.exports = Marty.createContainer RatingItem,
  listenTo: ['waypointsStore']

  fetch: ->
    waypoints: @app.waypointsStore.getAll()
