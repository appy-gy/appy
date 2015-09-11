React = require 'react/addons'
ReactRedux = require 'react-redux'
currentUserActions = require '../../actions/current_user'
PasswordInput = require '../shared/inputs/password'
showToast = require '../../helpers/toasts/show'

{PropTypes} = React
{LinkedStateMixin} = React.addons
{connect} = ReactRedux
{changePassword} = currentUserActions

SettingsPopup = React.createClass
  displayName: 'SettingsPopup'

  mixins: [LinkedStateMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    user: PropTypes.object.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'user-settings'

  getInitialState: ->
    oldPassword: ''
    newPassword: ''

  changePassword: (event) ->
    {dispatch, user} = @props
    {oldPassword, newPassword} = @state

    event.preventDefault()

    dispatch changePassword(oldPassword, newPassword)
      .then =>
        showToast dispatch, 'Пароль был успешно изменен', 'success'
        @setState oldPassword: '', newPassword: ''
      .catch ->
        showToast dispatch, 'Вы ввели неверный старый пароль', 'error'

  render: ->
    <div className="user-settings">
      <div className="user-settings_title">Смена пароля</div>
      <form className="user-settings_change-password" onSubmit={@changePassword}>
        <PasswordInput placeholder="Старый пароль" valueLink={@linkState 'oldPassword'}/>
        <PasswordInput placeholder="Новый пароль" valueLink={@linkState 'newPassword'}/>
        <input type="submit" className="user-settings_submit" value="Изменить"/>
      </form>
    </div>

module.exports = connect()(SettingsPopup)
