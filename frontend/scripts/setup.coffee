arrayEach = require './setup/array_each'
classify = require './setup/classify'
momentLocale = require './setup/moment_locale'

setup = ->
  arrayEach()
  classify()
  momentLocale()

module.exports = setup
