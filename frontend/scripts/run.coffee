_ = require 'lodash'
rehydrate = require './rehydrate'
router = require './router'

run = ->
  rehydrate()
  router()

module.exports = ->
  return run() if _.includes ['interactive', 'complete'], document.readyState
  document.addEventListener 'DOMContentLoaded', run
