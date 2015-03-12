arrayEach = require './setup/array_each'
classify = require './setup/classify'
momentLocale = require './setup/moment_locale'
routes = require './setup/routes'

setup = ->
  arrayEach()
  classify()
  momentLocale()

  document.addEventListener 'DOMContentLoaded', ->
    renderReact()
    routes()

module.exports = setup
