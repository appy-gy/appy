React = require 'react/addons'
Marty = require 'marty'

Logout = React.createClass
  displayName: 'Logout'

  mixins: [Marty.createAppMixin()]

  logOut: ->
    @app.currentUserActions.logOut()

  render: ->
    <div className="logout" onClick={@logOut}>
    </div>

module.exports = Logout
