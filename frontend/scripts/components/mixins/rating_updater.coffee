# If you want to use this mixin make sure
# that your component connected to redux

_ = require 'lodash'
ratingActions = require '../../actions/rating'
RequestQueue = require '../../helpers/request_queue'

{changeRatingUpdateStatus} = ratingActions

updateDelay = 2000
updateTimeoutId = null
requests = []
queue = new RequestQueue
batchQueue = new RequestQueue

performUpdates = (dispatch) ->
  dispatch changeRatingUpdateStatus('saving')

  prevRequests = requests
  batchQueue.add =>
    promises = prevRequests.map (request) -> queue.add request
    Promise.all(promises).then(
      (value) ->
        dispatch changeRatingUpdateStatus('done')
        requests = []
      , (error) ->
        dispatch changeRatingUpdateStatus('rejected')
    )

timeoutUpdatesPerform = (dispatch) ->
  clearUpdatesTimeout()
  updateTimeoutId = setTimeout _.partial(performUpdates, dispatch), updateDelay
  dispatch changeRatingUpdateStatus('pending')

clearUpdatesTimeout = ->
  clearTimeout updateTimeoutId if updateTimeoutId?

RatingUpdater =
  performSave: ->
    {dispatch} = @props

    timeoutUpdatesPerform dispatch

  queueUpdate: (request) ->
    {dispatch} = @props

    @cancelUpdate?()
    requests.push request
    @cancelUpdate = -> _.remove requests, (req) -> req == request
    timeoutUpdatesPerform dispatch

module.exports = RatingUpdater
