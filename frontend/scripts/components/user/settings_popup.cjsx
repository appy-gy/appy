React = require 'react/addons'
AppFromProps = require '../mixins/app_from_props'
PasswordInput = require '../shared/inputs/password'
showToast = require '../../helpers/toasts/show'

{PropTypes} = React
{LinkedStateMixin} = React.addons

SettingsPopup = React.createClass
  displayName: 'SettingsPopup'

  mixins: [LinkedStateMixin, AppFromProps]

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
      .then ({body, status}) =>
        return showToast @app, 'Вы ввели неверный старый пароль', 'error' unless status == 200
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
