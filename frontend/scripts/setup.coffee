applyExtensions = require './setup/apply_extensions'
renderReact = require './setup/render_react'
setAjaxDefaults = require './setup/set_ajax_defaults'

setup = ->
  applyExtensions()
  setAjaxDefaults()
  document.addEventListener 'DOMContentLoaded', ->
    renderReact()

module.exports = setup
