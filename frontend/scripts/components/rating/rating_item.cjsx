React = require 'react/addons'
Title = require './title'
Description = require './description'
RatingItemActionCreators = require '../../action_creators/rating_items'
RatingItemsStore = require '../../stores/rating_items'

{PropTypes} = React

RatingItem = React.createClass
  displayName: 'RatingItem'

  propTypes:
    ratingItem: PropTypes.object.isRequired

  render: ->
    {ratingItem} = @props

    <section className="rating-point">
      <div className="rating-point_title">
        <span className="rating-point_number">{ratingItem.position}</span>
        <Title object={ratingItem} actionCreator={RatingItemActionCreators}/>
      </div>
      <div className="rating-point_cover">
        <img src="http://lorempixel.com/870/400"/>
      </div>
      <div className="rating-point_description">
        <Description object={ratingItem} actionCreator={RatingItemActionCreators}/>
      </div>
      <div className="rating-point_actions">
        <div className="rating-point_minus ion-android-remove"></div>
        <div className="rating-point_mark">{ratingItem.mark}</div>
        <div className="rating-point_plus ion-android-add"></div>
      </div>
    </section>

module.exports = RatingItem
