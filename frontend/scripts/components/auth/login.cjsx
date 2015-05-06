React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserActionCreators = require '../../action_creators/current_user'
PopupActionCreators = require '../../action_creators/popups'
Popup = require '../../models/popup'
ToastActionCreators = require '../../action_creators/toasts'
Toast = require '../../models/toast'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  logIn: (data) ->
    CurrentUserActionCreators.logIn data
      .then (user) =>
        return @showFailToast() unless user?
        @closePopup()

  showPopup: ->
    PopupActionCreators.append @popup()

  closePopup: ->
    PopupActionCreators.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Вход" onSubmit={@logIn} onClose={@closePopup}/>

  showFailToast: ->
    toast = new Toast 'Неверный логин или пароль', type: 'error'
    ToastActionCreators.append toast

  render: ->
    <div className="auth_login" onClick={@showPopup}>
      Вход
    </div>

module.exports = Login
