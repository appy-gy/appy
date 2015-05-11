React = require 'react/addons'
CurrentUserActionCreators = require '../../action_creators/current_user'

{PureRenderMixin} = React.addons

Logout = React.createClass
  displayName: 'Logout'

  mixins: [PureRenderMixin]

  logOut: ->
    CurrentUserActionCreators.logOut()

  render: ->
    <div className="logout" onClick={@logOut}>
    </div>

module.exports = Logout
