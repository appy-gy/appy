_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'

{PropTypes} = React
{LinkedStateMixin} = React.addons

Form = React.createClass
  displayName: 'Form'

  mixins: [LinkedStateMixin]

  propTypes:
    onSubmit: PropTypes.func.isRequired

  getInitialState: ->
    email: ''
    password: ''
    showPassword: false

  triggerShowPassword: ->
    {showPassword} = @state

    @setState showPassword: not showPassword

  onSubmit: (event) ->
    {onSubmit} = @props
    {email, password} = @state

    event.preventDefault()

    onSubmit { email, password }

  render: ->
    {showPassword} = @state

    showPasswordClasses = classNames 'auth-popup_show-password', 'm-active': showPassword
    passwordInputType = if showPassword then 'text' else 'password'

    <form className="auth-popup_form" onSubmit={@onSubmit}>
      <div className="auth-popup_input-wrapper">
        <input type="text" className="auth-popup_input" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
      </div>
      <div className="auth-popup_input-wrapper">
        <input ref="passwordInput" type={passwordInputType} className="auth-popup_input m-password" placeholder="Пароль" valueLink={@linkState 'password'}/>
        <div ref="showPasswordButton" className={showPasswordClasses} onClick={@triggerShowPassword}></div>
      </div>
      <div className="auth-popup_submit" onClick={@onSubmit}></div>
      <input type="submit" value="" className="g-hidden"/>
    </form>

module.exports = Form
