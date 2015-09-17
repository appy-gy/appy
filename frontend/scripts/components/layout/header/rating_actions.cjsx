React = require 'react'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
Publish = require '../../shared/ratings/publish'
Delete = require '../../shared/ratings/delete'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxReactRouter

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

    <div className="header_rating-actions">
      <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>
      <Delete ref="delete" rating={rating} onDelete={@redirectToProfile}/>
    </div>

module.exports = connect()(RatingActions)
