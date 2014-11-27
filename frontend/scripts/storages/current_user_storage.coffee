$ = require 'jquery'
BaseStorage = require './base_storage'
User = require '../models/user'
AppDispatcher = require '../dispatcher/app_dispatcher'

_user = {}

class CurrentUserStorage extends BaseStorage
  constructor: ->
    @clear()

  getUser: ->
    _user

  preload: (user) ->
    _user = new User user

  clear: ->
    _user = {}

  loadUser: (data) ->
    return unless data
    $.ajax
      url: '/api/private/login',
      dataType: 'json',
      type: 'POST',
      data: data

      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')

      success: (data) ->
        _user = new User data

      error: (xhr, status, err) ->
        console.error status, err.toString()

module.exports = new CurrentUserStorage
