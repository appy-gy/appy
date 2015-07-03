React = require 'react/addons'

mockComponent = (component, tagName = 'div') ->
  sinon.stub component::, 'render', ->
    React.createElement tagName, null, @props.children

  -> component::render.restore()

module.exports = mockComponent
