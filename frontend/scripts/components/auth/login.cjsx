React = require 'react/addons'
LoginForm = require './login_form'
CurrentUserApi = require '../../state_sources/current_user'
PopupsActionCreators = require '../../action_creators/popups'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  logIn: (data) ->
    CurrentUserApi.logIn data

  showDialog: ->
    PopupsActionCreators.append @popup()

  hideDialog: ->
    PopupsActionCreators.remove @popup()

  popup: ->
    @popupCache ||= <LoginForm onSubmit={@logIn}/>

  render: ->
    <div onClick={@showDialog}>
      Login
    </div>

module.exports = Login
