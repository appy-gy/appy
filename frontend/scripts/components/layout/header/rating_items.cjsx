_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
sortRatingItems = require '../../../helpers/rating_items/sort'
RatingItem = require './rating_item'

{PropTypes} = React
{connect} = ReactRedux

RatingItems = React.createClass
  displayName: 'RatingItems'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    order: PropTypes.string.isRequired

  ratingItems: ->
    {ratingItems, rating, order} = @props

    marks = _.map ratingItems, 'mark'
    min = _.min marks
    max = _.max marks

    sectionColor = _.get rating, 'section.color', 'white'
    invertedSectionColor = _.get rating, 'section.invertedColor', 'black'

    _ sortRatingItems(ratingItems, order)
      .map (ratingItem, index) =>
        width = if min == max then 50 else (ratingItem.mark - min) / (max - min) * 100
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1} width={width} invertedSectionColor={invertedSectionColor} sectionColor={sectionColor}/>
      .value()

  render: ->
    {rating} = @props

    <div className="header_rating-items">
      <a href="#" className="header_rating-title" data-scroll>
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

mapStateToProps = ({rating, ratingItems}) ->
  rating: rating.item
  ratingItems: ratingItems.items
  order: ratingItems.order

module.exports = connect(mapStateToProps)(RatingItems)
