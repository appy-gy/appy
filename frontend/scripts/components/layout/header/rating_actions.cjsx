React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Publish = require '../../shared/ratings/publish'
Save = require '../../shared/ratings/save'
Delete = require '../../shared/ratings/delete'
Validations = require './validations'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter

RatingActions = React.createClass
  displayName: 'RatingActions'

  propTypes:
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'rating-statusbar'

  redirectToProfile: ->
    {dispatch, currentUser} = @props

    dispatch replaceState(null, "/users/#{currentUser.slug}")

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
            <Delete ref='delete' rating={rating} onDelete={@redirectToProfile}>&times;</Delete>
          </div>
        </div>
      </div>
    </div>

mapStateToProps = ({currentUser, rating, ratingItems}) ->
  currentUser: currentUser.item
  rating: rating.item
  ratingItems: ratingItems.items

module.exports = connect(mapStateToProps)(RatingActions)
