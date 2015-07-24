_ = require 'lodash'
mockComponent = require './mock_component'

mockComponents = (components...) ->
  restorers = _.flatten(components).map (component) ->
    mockComponent component

  ->
    restorers.forEach (restorer) ->
      restorer()
      true

module.exports = mockComponents
