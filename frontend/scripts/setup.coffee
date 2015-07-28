polyfillSetImmediate = require './setup/polyfill_set_immediate'
polyfillSet = require './setup/polyfill_set'
keepConsoleTrace = require './setup/keep_console_trace'
setWindowMarty = require './setup/set_window_marty'
arrayEach = require './setup/array_each'
classify = require './setup/classify'
momentLocale = require './setup/moment_locale'
addPluralizationRules = require './setup/add_pluralization_rules'

setup = ->
  polyfillSetImmediate()
  polyfillSet()
  keepConsoleTrace()
  setWindowMarty()
  arrayEach()
  classify()
  momentLocale()
  addPluralizationRules()

module.exports = setup
