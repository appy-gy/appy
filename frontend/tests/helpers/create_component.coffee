React = require 'react/addons'

{TestUtils} = React.addons

createComponent = (component, props, children...) ->
  renderer = TestUtils.createRenderer()
  element = React.createElement component, props, children...
  renderer.render element
  renderer.getRenderOutput()

module.exports = createComponent
