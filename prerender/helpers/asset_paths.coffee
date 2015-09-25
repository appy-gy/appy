fs = require 'fs'
path = require 'path'

paths = null

assetPaths = ->
  return paths if paths?
  console.log 'load asset paths', __dirname, fs.readFileSync(path.join(__dirname, '../../tmp/webpack/assets.json')).toString()
  data = JSON.parse fs.readFileSync path.join(__dirname, '../../tmp/webpack/assets.json')
  paths = data.app

module.exports = assetPaths
