_ = require 'lodash'
assetPaths = require '../helpers/asset_paths'

module.exports = ->
  switch process.env.TOP_ENV
    when 'production'
      paths = assetPaths()
      cssPath = paths.css
      jsPath = paths.js
      faviconPath = "#{process.env.TOP_ASSETS_HOST}/files/favicon.png"
    when 'development'
      cssPath = "#{process.env.TOP_WEBPACK_HOST}/app.css"
      jsPath = "#{process.env.TOP_WEBPACK_HOST}/app.js"
      faviconPath = '/files/favicon.png'

  (req, res, next) ->
    prevRender = res.render

    res.render = (view, locals) ->
      _.merge locals, { cssPath, jsPath, faviconPath, env: process.env.TOP_ENV, facebookAppId: process.env.TOP_FACEBOOK_APP_ID }
      prevRender.call res, view, locals

    next()
