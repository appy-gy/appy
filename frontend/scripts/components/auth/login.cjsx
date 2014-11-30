React = require 'react/addons'
LoginForm = require './login_form'
CurrentUserAction = require '../../actions/current_user_action'
ModalDialog = require '../dialog/modal'

Login = React.createClass
  signIn: (data) ->
    CurrentUserAction.login data

  showDialog: ->
    @refs.modalDialog.showDialog()

  render: ->
    <div>
      <a onClick={@showDialog}>Login</a>
      
      <ModalDialog title="SignIn" ref="modalDialog">
        <LoginForm onLoginFormSubmit={@signIn}/>
      </ModalDialog>
    </div>

module.exports = Login
