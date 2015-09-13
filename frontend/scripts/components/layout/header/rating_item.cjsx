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
    visible: PropTypes.arrayOf(PropTypes.string).isRequired

  ratingItemAnchor: ->
    {ratingItem} = @props

    "#item-#{ratingItem.position}"

  render: ->
    {ratingItem, visible} = @props

    classes = classNames 'header_rating-item', 'm-visible': _.includes(visible, ratingItem.id)

    <div className={classes}>
      <a title={ratingItem.title} className="header_rating-item-title" href={@ratingItemAnchor()} data-scroll>
        {ratingItem.title}
      </a>
      <div className="header_rating-item-options">
        {ratingItem.mark}
      </div>
    </div>

mapStateToProps = ({ratingItems}) ->
  visible: ratingItems.visible

module.exports = connect(mapStateToProps)(RatingItem)
