Marty = require 'marty'
isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  window.Marty = Marty
