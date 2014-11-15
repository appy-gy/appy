require('node-cjsx').transform()

require('../frontend/scripts/setup/apply_extensions')()

express = require 'express'
app = express()

_ = require 'lodash'
React = require 'react/addons'

getStorage = require '../frontend/scripts/helpers/get_storage'
getComponent = require '../frontend/scripts/helpers/get_component'

app.post '/', ({query: {component: componentPath, props, storages}}, res) ->
  _.each storages, (data, storagePath) ->
    storage = getStorage storagePath
    storage.preload JSON.parse(data)

  component = getComponent componentPath
  html = React.renderToString React.createElement(component, JSON.parse(props))

  res.send html

server = app.listen 8722, ->
  console.log 'Renderer listening'
