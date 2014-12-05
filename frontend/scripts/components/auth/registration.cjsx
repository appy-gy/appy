React = require 'react/addons'
RegForm = require './reg_form'
CurrentUserAction = require '../../actions/current_user_action'
ModalDialog = require '../dialog/modal'

Registration = React.createClass
  getInitialState: ->
    showDialog: false

  signUp: (data) ->
    CurrentUserAction.signUp data

  showDialog: ->
    @setState showDialog: true

  hideDialog: ->
    @setState showDialog: false

  render: ->
    {showDialog} = @state

    <div>
      <a onClick={@showDialog}>Registration</a>

      <ModalDialog title="SignUp" show={showDialog} onHide={@hideDialog}>
        <RegForm onRegFormSubmit={@signUp}/>
      </ModalDialog>
    </div>

module.exports = Registration
