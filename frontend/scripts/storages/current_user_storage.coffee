$ = require 'jquery'
User = require '../models/user'
AppDispatcher = require '../dispatcher/app_dispatcher'
EventEmitter = require('events').EventEmitter
merge = require('react/lib/merge')

user = {}

CurrentUserStorage = merge EventEmitter::,
  getUser: ->
    user

  preload: (user) ->
    user = new User user

  loadUser: (data) ->
    return unless data
    $.ajax
      url: '/api/private/user_sessions',
      dataType: 'json',
      type: 'POST',
      data: { user_session: data }

      success: (data) ->
        user = new User data
        CurrentUserStorage.emitChange()

      error: (xhr, status, err) ->
        console.error status, err.toString()

  clear: ->
    user = {}

  emitChange: ->
    @emit 'change'

  addChangeListener: (callback) ->
    @on 'change', callback

  removeChangeListener: (callback) ->
    @removeListener 'change', callback

AppDispatcher.register (payload) ->
  action = payload.action

  switch action.actionType
    when 'LOGIN'
      CurrentUserStorage.loadUser(action.data)
    else
      return true

module.exports = CurrentUserStorage
