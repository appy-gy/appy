http = require './http'
isClient = require './is_client'

subscribe = (registration) ->
  registration.pushManager.subscribe(userVisibleOnly: true)
    .then ({subscription}) ->
      saveSubscription subscription
    .catch ->

saveSubscription = ({endpoint}) ->
  browser = getBrowser endpoint
  return unless browser?
  http.patch '/api/private/browser_notification_subscriptions', subscription: { browser, info: { endpoint } }

getBrowser = (endpoint) ->
  if _.includes(endpoint, 'googleapis.com')
    'chrome'
  else if _.includes(endpoint, 'mozilla.com')
    'firefox'

init = ->
  return unless ServiceWorkerRegistration::showNotification?
  return if Notification.permission == 'denied'
  return unless window.PushManager?

  navigator.serviceWorker.ready.then (registration) ->
    registration.pushManager.getSubscription().then (subscription) ->

      return subscribe(registration) unless subscription?
      saveSubscription subscription

module.exports = ->
  return unless isClient()
  return unless navigator.serviceWorker?
  navigator.serviceWorker.register('/service-worker.js').then(init)
