React = require 'react/addons'
PasswordInput = require '../shared/inputs/password'
showToast = require '../../helpers/toasts/show'

{PropTypes} = React
{LinkedStateMixin} = React.addons

SettingsPopup = React.createClass
  displayName: 'SettingsPopup'

  mixins: [LinkedStateMixin]

  propTypes:
    user: PropTypes.object.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'user-settings'

  getInitialState: ->
    oldPassword: ''
    newPassword: ''

  changePassword: (event) ->
    {app, user} = @props
    {oldPassword, newPassword} = @state

    event.preventDefault()

    @app.usersApi.changePassword(user.id, oldPassword, newPassword)
      .then ({body, ok}) =>
        return showToast @app, 'Вы ввели неверный старый пароль', 'error' unless ok
        showToast @app, 'Пароль был успешно изменен', 'success'
        @setState oldPassword: '', newPassword: ''

  render: ->
    <div className="user-settings">
      <div className="user-settings_title">Смена пароля</div>
      <form className="user-settings_change-password" onSubmit={@changePassword}>
        <PasswordInput placeholder="Старый пароль" valueLink={@linkState 'oldPassword'}/>
        <PasswordInput placeholder="Новый пароль" valueLink={@linkState 'newPassword'}/>
        <input type="submit" className="user-settings_submit" value="Изменить"/>
      </form>
    </div>

module.exports = SettingsPopup
