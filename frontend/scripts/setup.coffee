require('./setup/apply_extensions')()

renderReact = require './setup/render_react'
setAjaxDefaults = require './setup/set_ajax_defaults'
setMomentLocale = require './setup/set_moment_locale'
routes = require './setup/routes'

setup = ->
  setAjaxDefaults()
  setMomentLocale()
  document.addEventListener 'DOMContentLoaded', ->
    renderReact()
    routes()

module.exports = setup
