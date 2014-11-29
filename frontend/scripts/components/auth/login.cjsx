React = require 'react/addons'
LoginForm = require './login_form'
CurrentUserAction = require '../../actions/current_user_action'

Login = React.createClass
  signIn: (data) ->
    CurrentUserAction.login data

  getInitialState: ->
    show: false

  showForm: ->
    @setState show: true

  render: ->
    if @state.show
      <LoginForm onLoginFormSubmit={@signIn}/>
    else
      <a onClick={@showForm}>Login</a>

module.exports = Login
