self.addEventListener 'push', (event) ->
  event.waitUntil fetch('/api/private/browser_notifications', credentials: 'include').then (response) ->
    response.json().then ({notification}) ->
      {title, body, icon, tag, url} = notification.payload
      self.registration.showNotification title, { body, icon, tag, data: { url } }

self.addEventListener 'notificationclick', (event) ->
  event.notification.close()
  return unless clients.openWindow?
  clients.openWindow event.notification.data.url
