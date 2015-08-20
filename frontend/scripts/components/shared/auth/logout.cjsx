React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

Logout = React.createClass
  displayName: 'Logout'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    block: PropTypes.string.isRequired

  logOut: (event) ->
    event.preventDefault()

    @app.currentUserActions.logOut()

  render: ->
    {block} = @context

    <div className="#{block}_logout" onClick={@logOut}>
      Выйти
    </div>

module.exports = Logout
