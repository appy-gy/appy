React = require 'react'

{PropTypes} = React

Popup = React.createClass
  displayName: 'Popup'

  propTypes:
    popup: PropTypes.object.isRequired

  render: ->
    {popup} = @props

    <div className="popups_popup">
      {popup.content()}
    </div>

module.exports = Popup
