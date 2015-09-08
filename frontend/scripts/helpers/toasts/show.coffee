_ = require 'lodash'
buildToast = require './build'

showToast = (app, content, opts) ->
  opts = type: opts if _.isString opts
  toast = buildToast content, opts
  app.toastsActions.append toast

module.exports = showToast
