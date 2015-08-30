_ = require 'lodash'
assetPaths = require '../helpers/asset_paths'

module.exports = ->
  switch process.env.TOP_ENV
    when 'production'
      paths = assetPaths()
      cssPath = "#{process.env.TOP_ASSETS_HOST}/#{paths.css}"
      jsPath = "#{process.env.TOP_ASSETS_HOST}/#{paths.js}"
    when 'development'
      cssPath = "#{process.env.TOP_WEBPACK_HOST}/app.css"
      jsPath = "#{process.env.TOP_WEBPACK_HOST}/app.js"

  (req, res, next) ->
    prevRender = res.render

    res.render = (view, locals) ->
      _.merge locals, { cssPath, jsPath, env: process.env.TOP_ENV, facebookAppId: process.env.TOP_FACEBOOK_APP_ID }
      prevRender.call res, view, locals

    next()
