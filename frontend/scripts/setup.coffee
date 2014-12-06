require('./setup/apply_extensions')()

renderReact = require './setup/render_react'
setAjaxDefaults = require './setup/set_ajax_defaults'
setMomentLocale = require './setup/set_moment_locale'

setup = ->
  setAjaxDefaults()
  setMomentLocale()
  document.addEventListener 'DOMContentLoaded', ->
    renderReact()

module.exports = setup
