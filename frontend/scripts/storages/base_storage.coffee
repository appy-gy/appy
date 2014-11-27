EventEmitter = require('events').EventEmitter

class BaseStorage extends EventEmitter
  emitChange: ->
    @emit 'change'

  addChangeListener: (callback) ->
    @on 'change', callback

  removeChangeListener: (callback) ->
    @removeListener 'change', callback

module.exports = BaseStorage
