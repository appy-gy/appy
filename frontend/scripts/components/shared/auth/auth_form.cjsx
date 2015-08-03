React = require 'react/addons'
Form = require './form'
PasswordInput = require '../inputs/password'

{PropTypes} = React
{LinkedStateMixin} = React.addons

AuthForm = React.createClass
  displayName: 'AuthForm'

  mixins: [LinkedStateMixin]

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'auth-popup'

  getInitialState: ->
    email: ''
    password: ''

  onSubmit: (event) ->
    {onSubmit} = @props
    {email, password} = @state

    event.preventDefault()

    onSubmit { email, password }

  render: ->
    <Form onSubmit={@onSubmit}>
      <div className="auth-popup_input-wrapper">
        <input type="text" className="auth-popup_input" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
      </div>
      <PasswordInput placeholder="Пароль" valueLink={@linkState 'password'}/>
    </Form>

module.exports = AuthForm
