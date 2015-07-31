RequestQueue = require '../../helpers/request_queue'

WithRequestQueue =
  componentWillMount: ->
    @requestQueue = new RequestQueue

  addToQueue: (request) ->
    @requestQueue.add request

  removeFromQueue: (request) ->
    @requestQueue.cancel request

  clearQueue: ->
    @requestQueue.clear()

module.exports = WithRequestQueue
