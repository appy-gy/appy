React = require 'react'

{PropTypes} = React

ConfirmationPopup = React.createClass
  displayName: 'ConfirmationPopup'

  propTypes:
    text: PropTypes.string.isRequired
    onConfirm: PropTypes.func.isRequired
    onCancel: PropTypes.func.isRequired
    confirmText: PropTypes.string
    cancelText: PropTypes.string

  getDefaultProps: ->
    confirmText: 'Да, пожалуйста'
    cancelText: 'Нет, не надо'

  render: ->
    {text, onConfirm, onCancel, confirmText, cancelText} = @props

    <div className="confirmation-popup">
      <div className="confirmation-popup_text">
        {text}
      </div>
      <div className="confirmation-popup_buttons">
        <div className="confirmation-popup_button m-accept" onClick={onConfirm}>
          {confirmText}
        </div>
        <div className="confirmation-popup_button m-cancel" onClick={onCancel}>
          {cancelText}
        </div>
      </div>
    </div>

module.exports = ConfirmationPopup
