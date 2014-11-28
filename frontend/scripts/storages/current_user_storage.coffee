$ = require 'jquery'
User = require '../models/user'
AppDispatcher = require '../dispatcher/app_dispatcher'
EventEmitter = require('events').EventEmitter
merge = require('react/lib/merge')

_user = {}

CurrentUserStorage = merge(EventEmitter::,
  getUser: ->
    _user

  preload: (user) ->
    _user = new User user

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
        CurrentUserStorage.emitChange()

      error: (xhr, status, err) ->
        console.error status, err.toString()

  emitChange: ->
    @emit 'change'

  addChangeListener: (callback) ->
    @on 'change', callback

  removeChangeListener: (callback) ->
    @removeListener 'change', callback
)

AppDispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when 'LOGIN'
      CurrentUserStorage.loadUser(action.data)
    else
      return true

module.exports = CurrentUserStorage
