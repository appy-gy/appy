_ = require 'lodash'

class RequestQueue
  constructor: ->
    @clear()
    @busy = false

  add: (request) ->
    @requests.push request
    @performNext()
    => @cancel request

  cancel: (request) ->
    _.remove @requests, (req) -> req == request

  clear: ->
    @requests = []

  performNext: ->
    return if @busy or _.isEmpty(@requests)
    request = @requests.shift()
    @perform request

  perform: (request) ->
    @busy = true
    @always request(), (result) =>
      @busy = false
      @performNext()
      result

  always: (promise, fn) ->
    promise.then fn, fn

module.exports = RequestQueue
