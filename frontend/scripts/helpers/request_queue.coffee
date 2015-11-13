_ = require 'lodash'

class RequestQueue
  constructor: ->
    @clear()
    @busy = false

  add: (request) ->
    new Promise (resolve, reject) =>
      @queue.push { request, resolve, reject }
      @performNext()

  cancel: (req) ->
    _.remove @queue, ({request}) -> request == req

  clear: ->
    @queue = []

  performNext: ->
    return if @busy or _.isEmpty(@queue)
    @perform @queue.shift()

  perform: ({request, resolve, reject}) ->
    @busy = true
    request()
      .then (result) =>
        @ensure resolve
        result
      .catch (error) =>
        @ensure reject

  ensure: (fn) =>
    @busy = false
    fn?()
    @performNext()

module.exports = RequestQueue
