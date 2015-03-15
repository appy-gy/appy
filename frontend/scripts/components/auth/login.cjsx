React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserApi = require '../../state_sources/current_user'
PopupsActionCreators = require '../../action_creators/popups'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  socialLogIn: (type) ->
    console.log 'social login', type

  logIn: (data) ->
    CurrentUserApi.logIn data

  showPopup: ->
    PopupsActionCreators.append @popup()

  closePopup: ->
    PopupsActionCreators.remove @popup()

  popup: ->
    @popupCache ||= <AuthPopup title="Вход" onSocialSubmit={@socialLogIn} onSubmit={@logIn} onClose={@closePopup}/>

  render: ->
    <div onClick={@showPopup}>
      Вход
    </div>

module.exports = Login
