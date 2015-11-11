React = require 'react'

{PropTypes} = React

LoginNotifier =
  childContextTypes:
    addLoginCallback: PropTypes.func.isRequired

  getChildContext: ->
    { @addLoginCallback }

  componentWillMount: ->
    @loginCallbacks = []

  componentDidUpdate: ({currentUser: prevCurrentUser}) ->
    {currentUser} = @props

    return if prevCurrentUser.id? or currentUser.id == prevCurrentUser.id

    @loginCallbacks.each (cb) -> cb currentUser
    @loginCallbacks = []

  addLoginCallback: (cb) ->
    if @props.currentUser.id? then cb() else @loginCallbacks.push(cb)

module.exports = LoginNotifier
