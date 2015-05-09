React = require 'react/addons'

{PureRenderMixin} = React.addons

FbRoot = React.createClass
  displayName: 'FbRoot'

  mixins: [PureRenderMixin]

  render: ->
    <div id="fb-root"></div>

module.exports = FbRoot
