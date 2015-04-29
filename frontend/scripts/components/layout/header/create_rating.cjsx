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
    <a className="new-rating-button">
      <span className="new-rating-button_icon">+</span>
      <span className="new-rating-button_text" onClick={@createRating}>Создать</span>
    </a>

module.exports = CreateRating
