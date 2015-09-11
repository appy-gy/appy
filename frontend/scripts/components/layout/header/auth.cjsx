React = require 'react/addons'
Info = require '../../shared/auth/info'
Login = require '../../shared/auth/login'
Registration = require '../../shared/auth/registration'
withIndexKeys = require '../../../helpers/react/with_index_keys'

{PropTypes} = React

Auth = React.createClass
  displayName: 'Auth'

  contextTypes:
    currentUser: PropTypes.object.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  getChildContext: ->
    block: 'auth'

  info: (user) ->
    <Info user={user}/>

  loginAndRegistration: (user) ->
    withIndexKeys [
      <Login className="auth_login">Вход</Login>
      <Registration className="auth_registration">Регистрация</Registration>
    ]

  auth: ->
    {currentUser} = @context

    components = if currentUser.id? then 'info' else 'loginAndRegistration'
    @[components] currentUser

  render: ->
    <div className="auth">
      {@auth()}
    </div>

module.exports = Auth
