React = require 'react/addons'
Title = require './title'
Login = -> require './login'
Form = require './form'
showToast = require '../../../helpers/toasts/show'

{PropTypes} = React
{LinkedStateMixin} = React.addons

ResetPasswordPopup = React.createClass
  displayName: 'ResetPasswordPopup'

  mixins: [LinkedStateMixin]

  componentWillMount: ->
    @Login = Login()

  getInitialState: ->
    email: ''

  resetPassword: (event) ->
    {email} = @state

    event.preventDefault()

    @app.resetPasswordApi.reset(email).then ({body, ok}) =>
      return @showFailToast() unless ok
      @showSuccessToast()
      popups = @app.popupsStore.getOfType('auth')
      @app.popupsActions.remove popups

  showFailToast: ->
    showToast @app, 'Не удалось отправить письмо для восстановления пароля', 'error'

  showSuccessToast: ->
    showToast @app, 'Письмо для восстановления пароля отправлено', 'success'

  render: ->
    <div className="auth-popup">
      <Title text="Восстановление пароля"/>
      <Form className="auth-popup_form" onSubmit={@resetPassword}>
        <div className="auth-popup_input-wrapper">
          <input type="text" className="auth-popup_input m-solo" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
        </div>
      </Form>
      <@Login className="auth-popup_link">
        Войти
      </@Login>
    </div>

module.exports = ResetPasswordPopup
