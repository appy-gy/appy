_ = require 'lodash'
disableComponent = require './mock_component'

disableComponents = (components...) ->
  restorers = _.flatten(components).map (component) ->
    disableComponent component

  ->
    restorers.each (restorer) -> restorer()

module.exports = disableComponents
