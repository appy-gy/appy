React = require 'react/addons'
LoginForm = require './login_form'
Dialog = require '../modal/dialog'
CurrentUserStore = require '../../stores/current_user'

{PureRenderMixin} = React.addons

Login = React.createClass
  displayName: 'Login'

  mixins: [PureRenderMixin]

  getInitialState: ->
    showDialog: false

  logIn: (email, password) ->
    CurrentUserStore.logIn email, password

  showDialog: ->
    @setState showDialog: true

  hideDialog: ->
    @setState showDialog: false

  render: ->
    {showDialog} = @state

    <div>
      <a onClick={@showDialog}>Login</a>
      <Dialog title="SignIn" show={showDialog} onHide={@hideDialog}>
        <LoginForm onLoginFormSubmit={@logIn}/>
      </Dialog>
    </div>

module.exports = Login
