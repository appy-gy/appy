_ = require 'lodash'
React = require 'react'
RatingItem = require './rating_item'
tinycolor = require 'tinycolor2'

{PropTypes} = React

RatingItems = React.createClass
  displayName: 'RatingItems'

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  ratingItems: ->
    {ratingItems, rating} = @context

    marks = _.map ratingItems, 'mark'
    min = _.min marks
    max = _.max marks

    sectionColor = _.get rating, 'section.color', 'white'
    invertedSectionColor = @invertColor sectionColor

    _ ratingItems
      .sortBy 'position'
      .map (ratingItem) =>
        width = (ratingItem.mark - min) / (max - min) * 100
        <RatingItem key={ratingItem.id} ratingItem={ratingItem} width={width} invertedSectionColor={invertedSectionColor} sectionColor={sectionColor}/>
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

module.exports = RatingItems
