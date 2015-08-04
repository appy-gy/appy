React = require 'react/addons'
Marty = require 'marty'
Popup = require '../../../models/popup'
Classes = require '../../mixins/classes'
ResetPasswordPopup = require './reset_password_popup'

ResetPassword = React.createClass
  displayName: 'ResetPassword'

  mixins: [Marty.createAppMixin(), Classes]

  showResetPasswordPopup: ->
    popups = @app.popupsStore.getOfType('auth')
    @app.popupsActions.remove popups

    popup = new Popup
      type: 'auth'
      content: <ResetPasswordPopup app={@app}/>
    @app.popupsActions.append popup

  render: ->
    <div className={@classes()} onClick={@showResetPasswordPopup}>
      Забыли пароль?
    </div>

module.exports = ResetPassword
