React = require 'react/addons'

{TestUtils} = React.addons

createComponent = (component, {props, context, children} = {}) ->
  children ||= []
  renderer = TestUtils.createRenderer()
  element = React.createElement component, props, children...
  renderer.render element, context
  renderer.getRenderOutput()

module.exports = createComponent
