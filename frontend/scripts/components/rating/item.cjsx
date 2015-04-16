React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

RatingItem = React.createClass
  displayName: 'RatingItem'

  render: ->
    {item} = @props

    <section className="rating-point">
      <div className="rating-point_title">
        <span className="rating-point_number">{item.position}</span>
        <span>{item.title}</span>
      </div>
      <div className="rating-point_cover">
        <img src="http://lorempixel.com/870/400"/>
      </div>
      <div className="rating-point_description">
        {item.description}
      </div>
      <div className="rating-point_actions">
        <div className="rating-point_minus ion-android-remove"></div>
        <div className="rating-point_mark">{item.mark}</div>
        <div className="rating-point_plus ion-android-add"></div>
      </div>
    </section>

module.exports = RatingItem
