React = require 'react/addons'
Title = require './title'
Description = require './description'
Votes = require './votes'
RatingItemActionCreators = require '../../action_creators/rating_items'
RatingItemsStore = require '../../stores/rating_items'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired
    index: PropTypes.number.isRequired

  childContextTypes:
    ratingItem: PropTypes.object.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingItem} = @props

    { ratingItem, block: 'rating-item' }

  render: ->
    {ratingItem, index} = @props

    <section className="rating-item">
      <div className="rating-item_header">
        <span className="rating-item_number">{index}</span>
        <Title object={ratingItem} actionCreator={RatingItemActionCreators}/>
      </div>
      <div className="rating-item_cover">
        <img className="rating-item_cover-image" src="http://lorempixel.com/870/400"/>
      </div>
      <div className="rating-item_description">
        <Description object={ratingItem} actionCreator={RatingItemActionCreators}/>
      </div>
      <Votes/>
    </section>

module.exports = RatingItem
