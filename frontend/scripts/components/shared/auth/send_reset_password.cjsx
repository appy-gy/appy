React = require 'react'
ReactRedux = require 'react-redux'
popupActions = require '../../../actions/popups'
buildPopup = require '../../../helpers/popups/build'
Classes = require '../../mixins/classes'
SendResetPasswordPopup = require './send_reset_password_popup'

{PropTypes} = React
{connect} = ReactRedux
{appendPopup, removePopupsWithType} = popupActions

SendResetPassword = React.createClass
  displayName: 'SendResetPassword'

  mixins: [Classes]

  propTypes:
    dispatch: PropTypes.func.isRequired

  showSendResetPasswordPopup: ->
    {dispatch} = @props

    dispatch removePopupsWithType('auth')

    popup = buildPopup
      type: 'auth'
      content: -> <SendResetPasswordPopup/>

    dispatch appendPopup(popup)

  render: ->
    <div className={@classes()} onClick={@showSendResetPasswordPopup}>
      Забыли пароль?
    </div>

module.exports = connect()(SendResetPassword)
