React = require 'react/addons'
Marty = require 'marty'
Info = require '../../shared/auth/info'
Login = require '../../shared/auth/login'
Registration = require '../../shared/auth/registration'
withIndexKeys = require '../../../helpers/react/with_index_keys'

{PropTypes} = React
{PureRenderMixin} = React.addons

Auth = React.createClass
  displayName: 'Auth'

  mixins: [PureRenderMixin]

  propTypes:
    user: PropTypes.object.isRequired

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
    {user} = @props

    components = if user.id? then 'info' else 'loginAndRegistration'
    @[components] user

  render: ->
    <div className="auth">
      {@auth()}
    </div>

module.exports = Marty.createContainer Auth,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
