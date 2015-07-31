_ = require 'lodash'
RequestQueue = require '../../helpers/request_queue'

updateDelay = 2000
updateTimeoutId = null
requests = []
queue = new RequestQueue
batchQueue = new RequestQueue

getStatus = (app) ->
  app.ratingUpdateStatusStore.get().result.status

performUpdates = (app) ->
  app.ratingUpdateStatusActions.set 'saving'

  prevRequests = requests
  batchQueue.add =>
    promises = prevRequests.map (request) -> queue.add request
    Promise.all(promises).then ->
      app.ratingUpdateStatusActions.set 'done'

  requests = []

timeoutUpdatesPerform = (app) ->
  clearTimeout updateTimeoutId if updateTimeoutId?
  updateTimeoutId = setTimeout _.partial(performUpdates, app), updateDelay
  app.ratingUpdateStatusActions.set 'pending'

RatingUpdater =
  queueUpdate: (request) ->
    @cancelUpdate?()
    requests.push request
    @cancelUpdate = -> _.remove requests, (req) -> req == request
    timeoutUpdatesPerform @app

module.exports = RatingUpdater
