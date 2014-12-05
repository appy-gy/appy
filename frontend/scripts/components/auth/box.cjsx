React = require 'react/addons'
Login = require './login'
Logout = require './logout'
Registration = require './registration'
CurrentUserStore = require '../../stores/current_user_store'

Box = React.createClass
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

    <ul className="auth-box">
      {<li>{user.email}</li> if user.loggedIn()}
      {<li><Logout user={user.email}/></li> if user.loggedIn()}

      {<li><Login user={user.email}/></li> unless user.loggedIn()}
      {<li><Registration user={user.email}/></li> unless user.loggedIn()}
    </ul>

module.exports = Box
