_ = require 'lodash'
_.str = require 'underscore.string'
React = require 'react/addons'
getComponent = require '../helpers/get_component'

module.exports = ->
  _.each document.querySelectorAll('[data-component]'), (element) ->
    componentPath = element.getAttribute 'data-component'
    component = getComponent componentPath
    props = JSON.parse element.getAttribute('data-props')
    React.render React.createElement(component, props), element
