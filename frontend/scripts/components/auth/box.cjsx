React = require 'react/addons'
Login = require './login'
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
      <li>{@state.user.email}</li>
      <li><Login /></li>
      <li><Registration /></li>
    </ul>

module.exports = Box
