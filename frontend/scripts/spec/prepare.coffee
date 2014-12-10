_ = require 'lodash'
applyExtensions = require '../setup/apply_extensions'
setMomentLocale = require '../setup/set_moment_locale'

module.exports = ->
  # For PhantomJS
  unless Function::bind?
    Object.defineProperty Function::, 'bind',
      value: (thisArg, args...) ->
        _.bind @, thisArg, args...

  applyExtensions()
  setMomentLocale()
