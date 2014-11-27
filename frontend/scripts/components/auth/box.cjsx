React = require 'react/addons'
Login = require './login'
Registration = require './registration'
{CurrentUserStorage} = require '../../storages'

getUser = ->
  user: CurrentUserStorage.getUser()

Box = React.createClass
  getInitialState: ->
    getUser()

  componentWillMount: ->
    CurrentUserStorage.addChangeListener @_onChange

  _onChange: ->
    @setState(getUser())

  render: ->
    <ul className="auth-box">
      <li>{@state.user}</li>
      <li><Login /></li>
      <li><Registration /></li>
    </ul>

module.exports = Box
