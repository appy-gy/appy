_ = require 'lodash'

module.exports = ->
  assetsHost = if process.env.TOP_ENV == 'development' then "#{process.env.TOP_WEBPACK_HOST}/" else '/static/'

  (req, res, next) ->
    prevRender = res.render

    res.render = (view, locals) ->
      _.merge locals, host: assetsHost, facebookAppId: process.env.TOP_FACEBOOK_APP_ID
      prevRender.call res, view, locals

    next()
