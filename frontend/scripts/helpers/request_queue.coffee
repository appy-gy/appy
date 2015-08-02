_ = require 'lodash'

class RequestQueue
  constructor: ->
    @clear()
    @busy = false

  add: (request) ->
    new Promise (resolve) =>
      @queue.push { request, resolve }
      @performNext()

  cancel: (req) ->
    _.remove @queue, ({request}) -> request == req

  clear: ->
    @queue = []

  performNext: ->
    return if @busy or _.isEmpty(@queue)
    @perform @queue.shift()

  perform: ({request, resolve}) ->
    @busy = true
    @always request(), (result) =>
      @busy = false
      resolve()
      @performNext()
      result

  always: (promise, fn) ->
    promise.then fn, fn

module.exports = RequestQueue
