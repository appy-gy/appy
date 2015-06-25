React = require 'react/addons'

{PropTypes} = React

ConfirmationPopup = React.createClass
  displayName: 'ConfirmationPopup'

  propTypes:
    text: PropTypes.string.isRequired
    onConfirm: PropTypes.func.isRequired
    onCancel: PropTypes.func.isRequired
    onConfirmText: PropTypes.string
    onCancelText: PropTypes.string

  getDefaultProps: ->
    onConfirmText: 'Да'
    onCancelText: 'Отмена'

  render: ->
    {text, onConfirm, onCancel, onConfirmText, onCancelText} = @props

    <div className="confirmation-popup">
      <div className="confirmation-popup_text">
        {text}
      </div>
      <div className="confirmation-popup_buttons">
        <div className="confirmation-popup_button" onClick={onConfirm}>
          {onConfirmText}
        </div>
        <div className="confirmation-popup_button" onClick={onCancel}>
          {onCancelText}
        </div>
      </div>
    </div>

module.exports = ConfirmationPopup
