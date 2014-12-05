_ = require 'lodash'
React = require 'react/addons'
getStore = require '../helpers/get_store'
getComponent = require '../helpers/get_component'

module.exports = ->
  _.each document.querySelectorAll('[data-store]'), (element) ->
    storePath = element.getAttribute 'data-store'
    store = getStore storePath
    data = JSON.parse element.getAttribute('data-data')
    store.preload data

  _.each document.querySelectorAll('[data-component]'), (element) ->
    componentPath = element.getAttribute 'data-component'
    component = getComponent componentPath
    props = JSON.parse element.getAttribute('data-props')
    React.render React.createElement(component, props), element
