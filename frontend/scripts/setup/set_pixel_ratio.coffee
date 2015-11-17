cookie = require 'cookie'
pixelRatio = require '../helpers/pixel_ratio'
isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  ratio = Math.round Math.min((window.devicePixelRatio || 1), 2)
  document.cookie = cookie.serialize 'pixel_ratio', ratio, maxAge: 10e+7
  pixelRatio.set ratio
