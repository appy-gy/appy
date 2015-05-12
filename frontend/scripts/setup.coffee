polyfillSetImmediate = require './setup/polyfill_set_immediate'
polyfillSet = require './setup/polyfill_set'
arrayEach = require './setup/array_each'
classify = require './setup/classify'
momentLocale = require './setup/moment_locale'

setup = ->
  polyfillSetImmediate()
  polyfillSet()
  arrayEach()
  classify()
  momentLocale()

module.exports = setup
