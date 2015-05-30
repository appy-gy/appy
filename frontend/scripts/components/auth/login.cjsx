React = require 'react/addons'
Marty = require 'marty'
AuthPopup = require './auth_popup'
Popup = require '../../models/popup'
Toast = require '../../models/toast'

Login = React.createClass
  displayName: 'Login'

  mixins: [Marty.createAppMixin()]

  logIn: (data) ->
    @app.currentUserActions.logIn data
      .then ({error}) =>
        return @showFailToast() if error?
        @closePopup()

  showPopup: ->
    @app.popupsActions.append @popup()

  closePopup: ->
    @app.popupsActions.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Вход" onSubmit={@logIn} onClose={@closePopup}/>

  showFailToast: ->
    toast = new Toast 'Неверный логин или пароль', type: 'error'
    @app.toastsActions.append toast

  render: ->
    <div className="auth_login" onClick={@showPopup}>
      Вход
    </div>

module.exports = Login
