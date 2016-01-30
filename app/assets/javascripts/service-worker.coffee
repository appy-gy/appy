self.addEventListener 'push', (event) ->
  event.waitUntil fetch('/api/private/browser_notifications', credentials: 'include').then (response) ->
    response.json().then ({notification}) ->
      return unless notification.payload.url?
      {id} = notification
      {title, body, icon, tag, url} = notification.payload
      self.registration.showNotification title, { body, icon, tag, data: { id, url } }

self.addEventListener 'notificationclick', (event) ->
  event.notification.close()
  return unless clients.openWindow?
  {id, url} = event.notification.data
  clients.openWindow url
  event.waitUntil fetch("/api/private/browser_notifications/#{id}/click", method: 'put', credentials: 'include')
