React = require 'react/addons'
RatingActionCreators = require '../../../action_creators/ratings'

{PropTypes} = React
{PureRenderMixin} = React.addons

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [PureRenderMixin]

  contextTypes:
    router: React.PropTypes.func

  createRating: ->
    {router} = @context

    RatingActionCreators.create().then ({body}) =>
      router.transitionTo 'rating', ratingId: body.rating.id

  render: ->
    <div className="header_rating-button" onClick={@createRating}>
      <span className="header_rating-button-icon">+</span>
      <span className="header_rating-button-text">
        Создать
      </span>
    </div>

module.exports = CreateRating
