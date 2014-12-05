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
    <ul className="auth-box">
      {<li>{@state.user.email}</li> if @state.user.loggedIn()}
      {<li><Logout user={@state.user.email}/></li> if @state.user.loggedIn()}

      {<li><Login user={@state.user.email}/></li> if not @state.user.loggedIn()}
      {<li><Registration user={@state.user.email}/></li> if not @state.user.loggedIn()}
    </ul>

module.exports = Box
