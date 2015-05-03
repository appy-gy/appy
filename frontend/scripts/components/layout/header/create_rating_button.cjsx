React = require 'react/addons'
CreateRating = require '../../shared/ratings/create'

{PureRenderMixin} = React.addons

CreateRatingButton = React.createClass
  displayName: 'CreateRatingButton'

  mixins: [PureRenderMixin]

  render: ->
    <CreateRating className="header_rating-button">
      <span className="header_rating-button-icon">+</span>
      <span className="header_rating-button-text">
        Создать
      </span>
    </CreateRating>

module.exports = CreateRatingButton
