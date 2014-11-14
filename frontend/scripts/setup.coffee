aliasEach = require './setup/alias_each'
renderReact = require './setup/render_react'

setup = ->
  document.addEventListener 'DOMContentLoaded', ->
    aliasEach()
    renderReact()

module.exports = setup
