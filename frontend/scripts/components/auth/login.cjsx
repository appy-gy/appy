React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserApi = require '../../state_sources/current_user'
PopupsActionCreators = require '../../action_creators/popups'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  logIn: (data) ->
    CurrentUserApi.logIn data
      .then (user) =>
        return unless user?.isLoggedIn()
        @closePopup()

  showPopup: ->
    PopupsActionCreators.append @popup()

  closePopup: ->
    PopupsActionCreators.remove @popup()

  popup: ->
    @popupCache ||= <AuthPopup title="Вход" onSubmit={@logIn} onClose={@closePopup}/>

  render: ->
    <div className="auth_login" onClick={@showPopup}>
      Вход
    </div>

module.exports = Login
