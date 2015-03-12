_ = require 'lodash'

class BaseStore
  constructor: ->
    @listeners = {}
    @callbacks = {}
    @registerDispatcherHandler()

  registerDispatcherHandler: ->
    Dispatcher.register ({action, data}) =>
      [name, type] = action.split ':'
      return unless @name == name
      @listeners[type]?.each (cb) -> cb data

  register: (type, cb) ->
    @listeners[type] ||= []
    @listeners[type].push cb

  emit: (type, data) ->
    @callbacks[type]?.each (cb) -> cb data

  on: (type, cb) ->
    @callbacks[type] ||= []
    @callbacks[type].push cb
    => @remove @callbacks[type], cb

  remove: (type, cb) ->
    _.remove @callbacks[type], cb

  once: (type, cb) ->
    remove = @on type, (data) ->
      cb data
      remove()

module.exports = BaseStore
