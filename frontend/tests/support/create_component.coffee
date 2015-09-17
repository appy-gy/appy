TestUtils = require 'react-addons-test-utils'

createComponent = (component, {props, context, children} = {}) ->
  children ||= []
  renderer = TestUtils.createRenderer()
  element = React.createElement component, props, children...
  renderer.render element, context
  renderer.getRenderOutput()

module.exports = createComponent
