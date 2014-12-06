React = require 'react/addons'
CurrentUserAction = require '../../actions/current_user_action'
LoginForm = require './login_form'
Dialog = require '../modal/dialog'

Login = React.createClass
  getInitialState: ->
    showDialog: false

  signIn: (data) ->
    CurrentUserAction.login data

  showDialog: ->
    @setState showDialog: true

  hideDialog: ->
    @setState showDialog: false

  render: ->
    {showDialog} = @state

    <div>
      <a onClick={@showDialog}>Login</a>

      <Dialog title="SignIn" show={showDialog} onHide={@hideDialog}>
        <LoginForm onLoginFormSubmit={@signIn}/>
      </Dialog>
    </div>

module.exports = Login
