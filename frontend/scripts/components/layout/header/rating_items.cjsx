_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
tinycolor = require 'tinycolor2'
RatingItem = require './rating_item'
sortRatingItems = require '../../../helpers/rating_items/sort'

{PropTypes} = React
{connect} = ReactRedux

RatingItems = React.createClass
  displayName: 'RatingItems'

  propTypes:
    order: PropTypes.string.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {order} = @props
    {ratingItems, rating} = @context

    marks = _.map ratingItems, 'mark'
    min = _.min marks
    max = _.max marks

    sectionColor = _.get rating, 'section.color', 'white'
    invertedSectionColor = @invertColor sectionColor

    _ sortRatingItems(ratingItems, order)
      .map (ratingItem, index) =>
        width = if min == max then 50 else (ratingItem.mark - min) / (max - min) * 100
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} index={index + 1} width={width} invertedSectionColor={invertedSectionColor} sectionColor={sectionColor}/>
      .value()

  invertColor: (color) ->
    rgbaMask = { r: 255, g: 255, b: 255, a: 0 }
    colorRgba = tinycolor(color).toRgb()

    invertedColor = _.transform colorRgba, (result, value, key) ->
      result[key] = rgbaMask[key] - value

    tinycolor(invertedColor).toRgbString()

  render: ->
    {rating} = @context

    <div className="header_rating-items">
      <a href="#" className="header_rating-title" data-scroll>
        {rating.title}
      </a>
      {@ratingItems()}
    </div>

mapStateToProps = ({ratingItems}) ->
  order: ratingItems.order

module.exports = connect(mapStateToProps)(RatingItems)
