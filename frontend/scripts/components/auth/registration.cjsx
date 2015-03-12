React = require 'react/addons'
RegForm = require './registration_form'
Dialog = require '../modal/dialog'

{PureRenderMixin} = React.addons

Registration = React.createClass
  displayName: 'Registration'

  mixins: [PureRenderMixin]

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
