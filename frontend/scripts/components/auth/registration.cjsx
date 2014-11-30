React = require 'react/addons'
RegForm = require './reg_form'
CurrentUserAction = require '../../actions/current_user_action'
ModalDialog = require '../dialog/modal'

Registration = React.createClass
  signUp: (data) ->
    CurrentUserAction.signUp data

  showDialog: ->
    @refs.modalDialog.showDialog()

  render: ->
    <div>
      <a onClick={@showDialog}>Registration</a>

      <ModalDialog title="SignUp" ref="modalDialog">
        <RegForm onRegFormSubmit={@signUp}/>
      </ModalDialog>
    </div>

module.exports = Registration
