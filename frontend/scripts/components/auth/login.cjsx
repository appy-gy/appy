React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserActionCreators = require '../../action_creators/current_user'
PopupActionCreators = require '../../action_creators/popups'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  logIn: (data) ->
    CurrentUserActionCreators.logIn data
      .then (user) =>
        return unless user?.isLoggedIn()
        @closePopup()

  showPopup: ->
    PopupActionCreators.append @popup()

  closePopup: ->
    PopupActionCreators.remove @popup()

  popup: ->
    @popupCache ||= <AuthPopup title="Вход" onSubmit={@logIn} onClose={@closePopup}/>

  render: ->
    <div className="auth_login" onClick={@showPopup}>
      Вход
    </div>

module.exports = Login
