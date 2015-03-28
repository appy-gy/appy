React = require 'react/addons'
Router = require 'react-router'

{PureRenderMixin} = React.addons
{Link} = Router

Logo = React.createClass
  displayName: 'Logo'

  mixins: [PureRenderMixin]

  render: ->
    <Link to="ratings" className="logotype">
      Activelist
    </Link>

module.exports = Logo
