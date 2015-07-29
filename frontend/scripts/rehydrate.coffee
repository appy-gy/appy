app = require './app'

rehydrate = ->
  app.rehydrate()
  document.querySelector('#__marty-state')?.remove()

module.exports = rehydrate
