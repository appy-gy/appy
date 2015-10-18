React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Publish = require '../../shared/ratings/publish'
Save = require '../../shared/ratings/save'
Delete = require '../../shared/ratings/delete'

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

    <div className="rating_statusbar">
      <div className="rating_statusbar-buttons">
        <Save ref='save' rating={rating} ratingItems={ratingItems}/>
        <div className="rating_statusbar-more">
          <div className="rating_statusbar-more-icon">
          </div>
          <div className="rating_statusbar-more-content-wrap">
            <div className="rating_statusbar-more-content">
              <Delete ref="delete" rating={rating} onDelete={@redirectToProfile}/>
            </div>
          </div>
        </div>
        <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>
      </div>
    </div>

module.exports = connect()(RatingActions)
