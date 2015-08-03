React = require 'react/addons'
Marty = require 'marty'
Popup = require '../../../models/popup'
ResetPasswordPopup = require './reset_password_popup'

ResetPassword = React.createClass
  displayName: 'ResetPassword'

  mixins: [Marty.createAppMixin()]

  showResetPasswordPopup: ->
    popups = @app.popupsStore.getOfType('auth')
    @app.popupsActions.remove popups

    popup = new Popup
      type: 'auth'
      content: <ResetPasswordPopup app={@app}/>
    @app.popupsActions.append popup

  render: ->
    <div className="auth-popup_reset-password" onClick={@showResetPasswordPopup}>
      Забыли пароль?
    </div>

module.exports = ResetPassword
