_ = require 'lodash'
mockComponent = require './mock_component'

mockComponents = (components...) ->
  restorers = _.flatten(components).map (component) ->
    mockComponent component

  ->
    restorers.each (restorer) -> restorer()

module.exports = mockComponents
