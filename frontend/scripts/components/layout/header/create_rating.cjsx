React = require 'react/addons'

{PureRenderMixin} = React.addons

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [PureRenderMixin]

  render: ->
    <a className="new-rating-button">
      <span className="new-rationg-button_icon">+</span>
      <span className="new-rationg-button_text">Создать</span>
    </a>

module.exports = CreateRating
