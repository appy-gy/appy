React = require 'react/addons'
Marty = require 'marty'
Info = require '../../auth/info'
Login = require '../../auth/login'
Logout = require '../../auth/logout'
Registration = require '../../auth/registration'
withIndexKeys = require '../../../helpers/react/with_index_keys'

{PropTypes} = React
{PureRenderMixin} = React.addons

Auth = React.createClass
  displayName: 'Auth'

  mixins: [PureRenderMixin]

  propTypes:
    user: PropTypes.object.isRequired

  infoAndLogOut: (user) ->
    withIndexKeys [
      <Info user={user}/>
      <Logout/>
    ]

  loginAndRegistration: (user) ->
    withIndexKeys [
      <Login/>
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
