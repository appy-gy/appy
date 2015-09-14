React = require 'react/addons'
ReactRedux = require 'react-redux'
popupActions = require '../../../actions/popups'
buildPopup = require '../../../helpers/popups/build'
Classes = require '../../mixins/classes'
ResetPasswordPopup = require './reset_password_popup'

{PropTypes} = React
{connect} = ReactRedux
{appendPopup, removePopupsWithType} = popupActions

ResetPassword = React.createClass
  displayName: 'ResetPassword'

  mixins: [Classes]

  propTypes:
    dispatch: PropTypes.func.isRequired

  showResetPasswordPopup: ->
    {dispatch} = @props

    dispatch removePopupsWithType('auth')

    popup = buildPopup
      type: 'auth'
      content: -> <ResetPasswordPopup/>

    dispatch appendPopup(popup)

  render: ->
    <div className={@classes()} onClick={@showResetPasswordPopup}>
      Забыли пароль?
    </div>

module.exports = connect()(ResetPassword)
