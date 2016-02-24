isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  window.localStorage ||= require 'localStorage'
