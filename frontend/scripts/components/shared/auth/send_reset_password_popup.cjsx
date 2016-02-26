React = require 'react'
LinkedStateMixin = require 'react-addons-linked-state-mixin'
ReactRedux = require 'react-redux'
currentUserActions = require '../../../actions/current_user'
popupActions = require '../../../actions/popups'
showToast = require '../../../helpers/toasts/show'
Title = require './title'
Login = -> require './login'
Form = require './form'

{PropTypes} = React
{connect} = ReactRedux
{sendResetPassword} = currentUserActions
{removePopupsWithType} = popupActions

SendResetPasswordPopup = React.createClass
  displayName: 'SendResetPasswordPopup'

  mixins: [LinkedStateMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired

  componentWillMount: ->
    @Login = Login()

  getInitialState: ->
    email: ''

  sendResetPassword: (event) ->
    {dispatch} = @props
    {email} = @state

    event.preventDefault()

    dispatch sendResetPassword(email)
      .then =>
        @showSuccessToast()
        dispatch removePopupsWithType('auth')
      .catch @showFailToast

  showFailToast: ->
    showToast @props.dispatch, 'Не удалось отправить письмо для восстановления пароля', 'error'

  showSuccessToast: ->
    showToast @props.dispatch, 'Письмо для восстановления пароля отправлено', 'success'

  render: ->
    <div className="auth-popup">
      <Title text="Восстановление пароля"/>
      <Form className="auth-popup_form" onSubmit={@sendResetPassword}>
        <div className="auth-popup_input-wrapper">
          <input type="text" className="auth-popup_input m-solo" autoFocus placeholder="Email" valueLink={@linkState 'email'}/>
        </div>
      </Form>
      <div className="auth-popup_links">
        <@Login className="auth-popup_link">
          Войти
        </@Login>
      </div>
    </div>

module.exports = connect()(SendResetPasswordPopup)
