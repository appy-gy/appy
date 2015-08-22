_ = require 'lodash'
Toast = require '../../models/toast'

showToast = (app, content, opts) ->
  opts = type: opts if _.isString opts
  toast = new Toast content, opts
  app.toastsActions.append toast

module.exports = showToast
