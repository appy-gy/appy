React = require 'react/addons'
RegForm = require './reg_form'
CurrentUserAction = require '../../actions/current_user_action'

Registration = React.createClass
  signUp: (data) ->
    CurrentUserAction.signUp data

  getInitialState: ->
    show: false

  showForm: ->
    @setState show: true

  render: ->
    if @state.show
      <RegForm onRegFormSubmit={@signUp}/>
    else
      <a onClick={@showForm}>Registration</a>

module.exports = Registration
