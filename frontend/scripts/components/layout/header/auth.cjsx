React = require 'react/addons'
Marty = require 'marty'
Info = require '../../shared/auth/info'
Login = require '../../shared/auth/login'
Logout = require '../../shared/auth/logout'
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

  infoAndLogOut: (user) ->
    withIndexKeys [
      <Info user={user}/>
      <Logout/>
    ]

  loginAndRegistration: (user) ->
    withIndexKeys [
      <Login>Вход</Login>
      <Registration/>
    ]

  auth: ->
    {user} = @props

    components = if user.isLoggedIn() then 'infoAndLogOut' else 'loginAndRegistration'
    @[components] user

  render: ->
    <div className="auth">
      {@auth()}
    </div>

module.exports = Marty.createContainer Auth,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
