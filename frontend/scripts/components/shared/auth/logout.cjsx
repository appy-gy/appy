React = require 'react/addons'
ReactRedux = require 'react-redux'
currentUserActions = require '../../../actions/current_user'

{PropTypes} = React
{connect} = ReactRedux
{logOut} = currentUserActions

Logout = React.createClass
  displayName: 'Logout'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  logOut: (event) ->
    {dispatch} = @props

    event.preventDefault()
    dispatch logOut()

  render: ->
    {block} = @context

    <div className="#{block}_logout" onClick={@logOut}>
      Выйти
    </div>

module.exports = connect()(Logout)
