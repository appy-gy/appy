React = require 'react/addons'
LoginForm = require './login_form'
CurrentUserAction = require '../../actions/current_user_action'
ModalDialog = require '../dialog/modal'

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

      <ModalDialog title="SignIn" show={showDialog} onHide={@hideDialog}>
        <LoginForm onLoginFormSubmit={@signIn}/>
      </ModalDialog>
    </div>

module.exports = Login
