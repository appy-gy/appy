React = require 'react/addons'
Toast = require '../../../models/toast'
AppFromProps = require '../../mixins/app_from_props'
AppToContext = require '../../mixins/app_to_context'
Title = require './title'
Login = -> require './login'
Form = require './form'

{PropTypes} = React
{LinkedStateMixin} = React.addons

ResetPasswordPopup = React.createClass
  displayName: 'ResetPasswordPopup'

  mixins: [LinkedStateMixin, AppFromProps, AppToContext]

  componentWillMount: ->
    @Login = Login()

  getInitialState: ->
    email: ''

  resetPassword: (event) ->
    {email} = @state

    event.preventDefault()

    @app.resetPasswordApi.reset(email).then ({body, status}) =>
      return @showFailToast() unless status == 200
      @showSuccessToast()
      popups = @app.popupsStore.getOfType('auth')
      @app.popupsActions.remove popups

  showFailToast: ->
    @showToast 'Не удалось отправить письмо для восстановления пароля', 'error'

  showSuccessToast: ->
    @showToast 'Письмо для восстановления пароля отправлено', 'success'

  showToast: (text, type) ->
    toast = new Toast text, { type }
    @app.toastsActions.append toast

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
