React = require 'react/addons'
CurrentUserAction = require '../../actions/current_user_action'

Logout = React.createClass
  signOut: ->
    CurrentUserAction.logout()

  render: ->
    <a onClick={@signOut}>Logout</a>

module.exports = Logout
