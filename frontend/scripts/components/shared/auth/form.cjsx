_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
PasswordInput = require '../inputs/password'

{PropTypes} = React
{LinkedStateMixin} = React.addons

Form = React.createClass
  displayName: 'Form'

  mixins: [LinkedStateMixin]

  propTypes:
    onSubmit: PropTypes.func.isRequired

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
    <form className="auth-popup_form" onSubmit={@onSubmit}>
      <div className="auth-popup_input-wrapper">
        <input type="text" className="auth-popup_input" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
      </div>
      <PasswordInput placeholder="Пароль" valueLink={@linkState 'password'}/>
      <div className="auth-popup_submit" onClick={@onSubmit}></div>
      <input type="submit" value="" className="g-hidden"/>
    </form>

module.exports = Form
