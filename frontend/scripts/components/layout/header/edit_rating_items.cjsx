_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
RatingItem = require './edit_rating_item'

{PropTypes} = React
{connect} = ReactRedux

EditRatingItems = React.createClass
  displayName: 'EditRatingItems'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems} = @props

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem, index) ->
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1}/>
      .value()

  render: ->
    {rating} = @props

    <div className="header_rating-items">
      <a href="#" className="header_rating-title">
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

mapStateToProps = ({rating, ratingItems}) ->
  rating: rating.item
  ratingItems: ratingItems.items

module.exports = connect(mapStateToProps)(EditRatingItems)
