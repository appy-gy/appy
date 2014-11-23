$ = require 'jquery'
React = require 'react/addons'
LoginForm = require './login_form'
{CurrentUserStorage} = require '../../storages'


Login = React.createClass
  login: (data) ->
    $.ajax
      url: '/api/private/login',
      dataType: 'json',
      type: 'POST',
      data: data

      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')

      success: (data) ->
        CurrentUserStorage.preload data

      error: (xhr, status, err) ->
        console.error status, err.toString()

  getInitialState: ->
    show: false

  handleClick: ->
    @setState show: true

  render: ->
    if @state.show
      <LoginForm onLoginFormSubmit={@login}/>
    else
      <a onClick={@handleClick}>Login</a>

module.exports = Login
