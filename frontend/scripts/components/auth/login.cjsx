React = require 'react/addons'
LoginForm = require './login_form'
CurrentUserAction = require '../../actions/current_user_action'

Login = React.createClass
  login: (data) ->
    CurrentUserAction.login(data)

  getInitialState: ->
    show: false

  handleClick: ->
    @setState show: true

  render: ->
    if @state.show
      <LoginForm onLoginFormSubmit={@login}/>
    else
      <a onClick={@handleClick}>Login</a>

module.exports = Login
