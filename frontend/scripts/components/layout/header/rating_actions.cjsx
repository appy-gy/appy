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

  contextTypes:
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  redirectToProfile: ->
    @props.dispatch replaceState(null, "/users/#{@context.currentUser.slug}")

  render: ->
    {rating, ratingItems} = @context
    <div className="rating-statusbar_wrap">
      <div className="grid">
        <div className="header_rating-publish-info">
          <Validations/>
        </div>
        <div className="rating-statusbar">
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

module.exports = connect()(RatingActions)
