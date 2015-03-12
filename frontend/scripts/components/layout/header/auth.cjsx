React = require 'react/addons'
CurrentUserStore = require '../../stores/current_user_store'
Login = require '../auth/login'
Logout = require '../auth/logout'
Registration = require '../auth/registration'

Auth = React.createClass
  getInitialState: ->
    user: @getUser()

  componentWillMount: ->
    CurrentUserStore.on 'change', @changeUser

  changeUser: ->
    @setState user: @getUser()

  getUser: ->
    CurrentUserStore.getUser()

  render: ->
    {user} = @state

    <ul>
      {<li>{user.email}</li> if user.loggedIn()}
      {<li><Logout user={user.email}/></li> if user.loggedIn()}

      {<li><Login user={user.email}/></li> unless user.loggedIn()}
      {<li><Registration user={user.email}/></li> unless user.loggedIn()}
    </ul>

module.exports = Auth
