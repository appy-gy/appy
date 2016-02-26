React = require 'react'
ReactRedux = require 'react-redux'
PureRenderMixin = require 'react-addons-pure-render-mixin'
LinkedStateMixin = require 'react-addons-linked-state-mixin'
currentUserActions = require '../../../actions/current_user'
popupActions = require '../../../actions/popups'
showToast = require '../../../helpers/toasts/show'
Title = require '../auth/title'
Form = require '../auth/form'
PasswordInput = require '../inputs/password'

{PropTypes} = React
{connect} = ReactRedux
{resetPassword} = currentUserActions
{removePopupsWithType} = popupActions

ResetPasswordPopup = React.createClass
  displayName: 'ResetPasswordPopup'

  mixins: [PureRenderMixin, LinkedStateMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    token: PropTypes.string.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getInitialState: ->
    password: ''

  getChildContext: ->
    block: 'auth-popup'

  close: ->
    @props.dispatch removePopupsWithType('resetPassword')

  resetPassword: ->
    {dispatch, token} = @props
    {password} = @state

    dispatch resetPassword({token, password})
      .then =>
        showToast dispatch, 'Пароль изменен'
        @close()
      .catch =>
        showToast dispatch, 'Не удалось сменить пароль', 'error'
        @close()
        throw new Error

  render: ->
    <div className="auth-popup">
      <Title text="Сменить пароль"/>
      <Form onSubmit={@resetPassword}>
        <PasswordInput placeholder="Пароль" valueLink={@linkState 'password'}/>
      </Form>
    </div>

module.exports = connect()(ResetPasswordPopup)
