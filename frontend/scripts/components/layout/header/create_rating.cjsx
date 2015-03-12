React = require 'react/addons'

CreateRating = React.createClass
  render: ->
    <a className="new-rating-button">
      <span className="new-rationg-button_icon">+</span>
      <span className="new-rationg-button_text">Создать</span>
    </a>

module.exports = CreateRating
