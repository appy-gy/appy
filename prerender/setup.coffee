dotenv = require 'dotenv'
setup = require '../frontend/scripts/setup'

module.exports = ->
  dotenv.load()
  setup()
