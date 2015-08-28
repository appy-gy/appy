fs = require 'fs'
path = require 'path'

paths = null

assetPaths = ->
  return paths if paths?
  data = JSON.parse fs.readFileSync path.join(__dirname, '../../tmp/webpack/assets.json')
  paths = data.app

module.exports = assetPaths