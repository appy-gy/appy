React = require 'react/addons'

{PropTypes} = React

Popup = React.createClass
  displayName: 'Popup'

  propTypes:
    popup: PropTypes.object.isRequired

  closePopup: ->
    {popup} = @props

    popup.close()

  render: ->
    {popup} = @props

    <div className="popups_popup">
      {popup.content}
      <div className="popups_popup-close" onClick={@closePopup}></div>
    </div>

module.exports = Popup
