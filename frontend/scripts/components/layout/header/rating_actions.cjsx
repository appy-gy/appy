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
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  redirectToProfile: ->
    @props.dispatch replaceState(null, "/users/#{@props.currentUser.slug}")

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
            <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>
            <div className="rating-statusbar_more">
              <div className="rating-statusbar_more-icon">
              </div>
              <div className="rating-statusbar_more-content-wrap">
                <div className="rating-statusbar_more-content">
                  <Delete ref="delete" rating={rating} onDelete={@redirectToProfile}/>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

mapStateToProps = ({currentUser, rating, ratingItems}) ->
  currentUser: currentUser.item
  rating: rating.item
  ratingItems: ratingItems.items

module.exports = connect(mapStateToProps)(RatingActions)
