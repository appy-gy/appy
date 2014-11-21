require('node-cjsx').transform()

require('../frontend/scripts/setup/apply_extensions')()

express = require 'express'
app = express()

React = require 'react/addons'

getComponent = require '../frontend/scripts/helpers/get_component'

Context = require './context'
contexts = {}

app.post '/contexts', (_, res) ->
  context = new Context
  contexts[context.uuid] = context
  res.send context.uuid

app.delete '/contexts/:uuid', ({params: {uuid}}, res) ->
  delete contexts[uuid]
  res.send 'ok'

app.post '/contexts/:uuid/storages', ({params: {uuid}, query: {path, data}}, res) ->
  context = contexts[uuid]
  context.store path, JSON.parse(data)
  res.send 'ok'

app.post '/contexts/:uuid/render',({params: {uuid}, query: {path, props}}, res) ->
  context = contexts[uuid]
  component = getComponent path

  html = context.withFilledStorages ->
    React.renderToString React.createElement(component, JSON.parse(props))

  res.send html

server = app.listen 8722, ->
  console.log 'Renderer listening'
