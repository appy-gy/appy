applyExtensions = require './setup/apply_extensions'
renderReact = require './setup/render_react'

setup = ->
  applyExtensions()
  document.addEventListener 'DOMContentLoaded', ->
    renderReact()

module.exports = setup
