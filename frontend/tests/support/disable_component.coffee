_ = require 'lodash'
mockComponent = require './mock_components'

disableComponent = (component) ->
  _.functions(component).each (name) ->
    return if name == 'render'
    component[name] = ->

  mockComponent component

module.exports = disableComponent
