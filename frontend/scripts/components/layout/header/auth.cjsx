React = require 'react/addons'
Marty = require 'marty'
CurrentUserStore = require '../../../stores/current_user'
Info = require '../../auth/info'
Login = require '../../auth/login'
Logout = require '../../auth/logout'
Registration = require '../../auth/registration'

{PropTypes} = React
{PureRenderMixin} = React.addons

Auth = React.createClass
  displayName: 'Auth'

  mixins: [PureRenderMixin]

  propTypes:
    user: PropTypes.object.isRequired

  infoAndLogOut: (user) ->
    [
      <Info key="info" user={user}></Info>
      <Logout key="logout"/>
    ]

  loginAndRegistration: (user) ->
    [
      <Login key="login"/>
      <Registration key="registration"/>
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
  listenTo: CurrentUserStore

  fetch: ->
    user: CurrentUserStore.for(@).get()
