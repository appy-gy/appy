arrayEach = require './setup/array_each'
classify = require './setup/classify'
momentLocale = require './setup/moment_locale'
router = require './router'

setup = ->
  arrayEach()
  classify()
  momentLocale()

  document.addEventListener 'DOMContentLoaded', ->
    router()

module.exports = setup
