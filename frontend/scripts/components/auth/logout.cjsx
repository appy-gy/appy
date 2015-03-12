React = require 'react/addons'
CurrentUserStore = require '../../stores/current_user'

{PureRenderMixin} = React.addons

Logout = React.createClass
  displayName: 'Logout'

  mixins: [PureRenderMixin]

  logOut: ->
    CurrentUserAction.logout()

  render: ->
    <a onClick={@logOut}>
      Logout
    </a>

module.exports = Logout
