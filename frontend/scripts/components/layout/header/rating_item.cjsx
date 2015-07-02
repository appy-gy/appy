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

  changePosition: (newPosition) ->
    {ratingItem} = @props

    @app.ratingItemsActions.changePosition ratingItem.id, newPosition

  updatePositions: ->
    {ratingItem} = @props

    @app.ratingsActions.updatePositions ratingItem.ratingId

  ratingItemAnchor: ->
    {ratingItem} = @props

    "##{ratingItem.id}"

  render: ->
    {ratingItem} = @props

    classes = classNames 'header_rating-item'

    <div className={classes}>
      <div className="header_rating-item-title">
        <a href={@ratingItemAnchor()} >
          {ratingItem.title}
        </a>
      </div>
      <div className="header_rating-item-options">
        {ratingItem.mark}
      </div>
    </div>

module.exports = RatingItem
