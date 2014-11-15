_ = require 'lodash'
React = require 'react/addons'
getStorage = require '../helpers/get_storage'
getComponent = require '../helpers/get_component'

module.exports = ->
  _.each document.querySelectorAll('[data-storage]'), (element) ->
    storagePath = element.getAttribute 'data-storage'
    storage = getStorage storagePath
    data = JSON.parse element.getAttribute('data-data')
    storage.preload data

  _.each document.querySelectorAll('[data-component]'), (element) ->
    componentPath = element.getAttribute 'data-component'
    component = getComponent componentPath
    props = JSON.parse element.getAttribute('data-props')
    React.render React.createElement(component, props), element
