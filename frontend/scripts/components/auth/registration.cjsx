React = require 'react/addons'
CurrentUserAction = require '../../actions/current_user_action'
RegForm = require './reg_form'
Dialog = require '../modal/dialog'

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

      <Dialog title="SignUp" show={showDialog} onHide={@hideDialog}>
        <RegForm onRegFormSubmit={@signUp}/>
      </Dialog>
    </div>

module.exports = Registration
