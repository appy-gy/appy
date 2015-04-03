Marty = require 'marty'

rehydrate = ->
  Marty.rehydrate()
  document.querySelector('#__marty-state').remove()

module.exports = rehydrate
