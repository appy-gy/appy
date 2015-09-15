_ = require 'lodash'
fs = require 'fs'
path = require 'path'
assetPaths = require '../helpers/asset_paths'

module.exports = ->
  switch process.env.TOP_ENV
    when 'production'
      paths = assetPaths()
      cssPath = path.join __dirname, '../../public', paths.css.replace(process.env.TOP_ASSETS_HOST, '')
      css = fs.readFileSync cssOath
      jsPath = paths.js
      faviconPath = "#{process.env.TOP_ASSETS_HOST}/files/favicon.png"
    when 'development'
      css = ''
      jsPath = "#{process.env.TOP_WEBPACK_HOST}/app.js"
      faviconPath = '/files/favicon.png'

  (req, res, next) ->
    prevRender = res.render

    res.render = (view, locals = {}) ->
      _.merge locals, { css, jsPath, faviconPath, env: process.env.TOP_ENV, facebookAppId: process.env.TOP_FACEBOOK_APP_ID }
      prevRender.call res, view, locals

    next()
