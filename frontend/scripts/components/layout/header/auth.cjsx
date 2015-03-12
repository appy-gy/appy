React = require 'react/addons'
CurrentUserStore = require '../../../stores/current_user'
Listener = require '../../mixins/listener'
Info = require '../../auth/info'
Login = require '../../auth/login'
Logout = require '../../auth/logout'
Registration = require '../../auth/registration'

{PureRenderMixin} = React.addons

Auth = React.createClass
  displayName: 'Auth'

  mixins: [PureRenderMixin, Listener]

  getInitialState: ->
    user: @getUser()

  componentWillMount: ->
    @addListener CurrentUserStore.addChangeListener(@updateUser)

  getUser: ->
    CurrentUserStore.get()

  updateUser: ->
    @setState user: @getUser()

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
    {user} = @state

    user.when
      pending: ->
      done: (user) =>
        components = if user.loggedIn() then 'infoAndLogOut' else 'loginAndRegistration'
        @[components] user

  render: ->
    <div>
      {@auth()}
    </div>

module.exports = Auth
