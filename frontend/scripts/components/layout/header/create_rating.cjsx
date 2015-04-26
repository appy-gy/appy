React = require 'react/addons'
Router = require 'react-router'
RatingActionCreators = require '../../../action_creators/ratings'

{PureRenderMixin} = React.addons

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [PureRenderMixin, Router.Navigation]

  createRating: ->
    RatingActionCreators.create().then ({body}) =>
      @transitionTo 'rating', ratingId: body.rating.id

  render: ->
    <a className="new-rating-button">
      <span className="new-rating-button_icon">+</span>
      <span className="new-rating-button_text" onClick={@createRating}>Создать</span>
    </a>

module.exports = CreateRating
