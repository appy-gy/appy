rehydrate = require './rehydrate'
router = require './router'

run = ->
  document.addEventListener 'DOMContentLoaded', ->
    rehydrate()
    router()

module.exports = run
