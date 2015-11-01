cookie = require 'cookie'
pixelRatio = require '../helpers/pixel_ratio'
isClient = require '../helpers/is_client'

module.exports = ->
  return unless isClient()
  ratio = window.devicePixelRatio
  document.cookie = cookie.serialize 'pixel_ratio', ratio, maxAge: 10e+7
  pixelRatio.set ratio
