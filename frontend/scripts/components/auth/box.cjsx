React = require 'react/addons'
Login = require './login'
Registration = require './registration'
{CurrentUserStorage} = require '../../storages'

Box = React.createClass
  getInitialState: ->
    user: @getUser()

  componentWillMount: ->
    CurrentUserStorage.on 'change', @changeUser

  changeUser: ->
    @setState user: @getUser()

  getUser: ->
    CurrentUserStorage.getUser()

  render: ->
    <ul className="auth-box">
      <li>{@state.user.email}</li>
      <li><Login /></li>
      <li><Registration /></li>
    </ul>

module.exports = Box
