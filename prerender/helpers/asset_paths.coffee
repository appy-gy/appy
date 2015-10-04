_ = require 'lodash'
fs = require 'fs'
path = require 'path'

paths = null

assetPaths = ->
  return paths if paths?
  {app: paths} = JSON.parse fs.readFileSync path.join(__dirname, '../../tmp/webpack/assets.json')
  if process.env.TOP_ENV == 'production'
    paths.fonts = fs.readdirSync(path.join(__dirname, '../../public/static'))
      .filter (file) -> _.endsWith file, '.woff'
      .map (font) -> "#{process.env.TOP_ASSETS_HOST}/static/#{font}"
  paths

module.exports = assetPaths
