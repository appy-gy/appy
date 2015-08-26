React = require 'react/addons'
Router = require 'react-router'

{PureRenderMixin} = React.addons
{Link} = Router

Logo = React.createClass
  displayName: 'Logo'

  mixins: [PureRenderMixin]

  render: ->
    <Link to="root" className="header_logotype">
      <div className="header_logotype-icon"></div>
      <div className="header_logotype-text">.appy</div>
    </Link>

module.exports = Logo
