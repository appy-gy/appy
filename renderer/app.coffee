require('node-cjsx').transform()

express = require 'express'
app = express()

React = require 'react/addons'

components = require '../frontend/scripts/components'
getComponent = require '../frontend/scripts/helpers/get_component'

app.post '/', ({query: {component: componentName, props}}, res) ->
  component = getComponent componentName
  html = React.renderToString React.createElement(component, JSON.parse(props))
  res.send html

server = app.listen 8722, ->
  console.log 'Renderer listening'
