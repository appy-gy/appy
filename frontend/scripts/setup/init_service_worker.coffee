_ = require 'lodash'
http = require '../helpers/http'
isClient = require '../helpers/is_client'

userId = null

prevSubscription = ->
  return unless localStorage.browserNotificationSubscription
  JSON.parse localStorage.browserNotificationSubscription

subscribe = (registration) ->
  registration.pushManager.subscribe(userVisibleOnly: true)
    .then (subscription) ->
      saveSubscription subscription
    .catch ->

saveSubscription = ({endpoint}) ->
  browser = getBrowser endpoint
  return unless browser?
  subscription = { browser, endpoint, userId }
  return if _.isEqual subscription, prevSubscription()
  http.patch('browser_notification_subscriptions', { subscription }).then ->
    localStorage.browserNotificationSubscription = JSON.stringify subscription

getBrowser = (endpoint) ->
  if _.includes(endpoint, 'googleapis.com')
    'chrome'
  else if _.includes(endpoint, 'mozilla.com')
    'firefox'

update = ->
  return unless ServiceWorkerRegistration::showNotification?
  return unless window.PushManager?

  Notification.requestPermission().then (permission) ->
    return if permission == 'denied'
    navigator.serviceWorker.register('/service-worker.js').then ->
      navigator.serviceWorker.ready.then (registration) ->
        registration.pushManager.getSubscription().then (subscription) ->
          return subscribe(registration) unless subscription?
          saveSubscription subscription

module.exports = ->
  return unless isClient()
  return unless navigator.serviceWorker?

  getStore = require '../get_store'

  update()

  getStore().then (store) ->
    store.subscribe ->
      newUserId = store.getState().currentUser.item.id
      return if userId == newUserId
      userId = newUserId
      update()
