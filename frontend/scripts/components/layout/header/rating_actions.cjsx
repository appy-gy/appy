React = require 'react'
ReactRedux = require 'react-redux'
Publish = require '../../shared/ratings/publish'
Save = require '../../shared/ratings/save'
Delete = require '../../shared/ratings/delete'
Validations = require './validations'

{PropTypes} = React
{connect} = ReactRedux

RatingActions = React.createClass
  displayName: 'RatingActions'

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  render: ->
    {rating, ratingItems} = @props

    <div className="rating-statusbar_wrap">
      <div className="grid">
        <div className="rating-statusbar">
          <div className="header_rating-publish-info">
            <Validations rating={rating} ratingItems={ratingItems}/>
          </div>
          <div className="rating-statusbar_buttons">
            <Save ref='save' rating={rating} ratingItems={ratingItems}/>
          </div>
        </div>
      </div>
    </div>

mapStateToProps = ({rating, ratingItems}) ->
  rating: rating.item
  ratingItems: ratingItems.items

module.exports = connect(mapStateToProps)(RatingActions)
