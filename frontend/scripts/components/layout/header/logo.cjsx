React = require 'react/addons'
Router = require 'react-router'

{PureRenderMixin} = React.addons
{Link} = Router

Logo = React.createClass
  displayName: 'Logo'

  mixins: [PureRenderMixin]

  render: ->
    <Link to="root" className="header_logotype">
    </Link>

module.exports = Logo
