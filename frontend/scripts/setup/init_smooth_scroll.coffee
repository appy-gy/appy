isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  smoothScroll = require 'smooth-scroll'
  smoothScroll.init updateURL: false
