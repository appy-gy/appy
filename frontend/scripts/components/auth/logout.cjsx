React = require 'react/addons'
CurrentUserApi = require '../../state_sources/current_user'

{PureRenderMixin} = React.addons

Logout = React.createClass
  displayName: 'Logout'

  mixins: [PureRenderMixin]

  logOut: ->
    CurrentUserApi.logOut()

  render: ->
    <div onClick={@logOut}>
      Logout
    </div>

module.exports = Logout
