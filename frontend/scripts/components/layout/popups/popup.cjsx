React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

Popup = React.createClass
  displayName: 'Popup'

  mixins: [Marty.createAppMixin()]

  propTypes:
    popup: PropTypes.object.isRequired

  closePopup: ->
    {popup} = @props

    @app.popupsActions.remove popup

  render: ->
    {popup} = @props

    <div className="popups_popup">
      {popup.content}
      <div className="popups_popup-close" onClick={@closePopup}></div>
    </div>

module.exports = Popup
