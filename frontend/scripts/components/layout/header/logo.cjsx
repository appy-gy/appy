React = require 'react/addons'

{PureRenderMixin} = React.addons

Logo = React.createClass
  displayName: 'Logo'

  mixins: [PureRenderMixin]

  render: ->
    <a href="/" className="logotype">
      Activelist
    </a>

module.exports = Logo
