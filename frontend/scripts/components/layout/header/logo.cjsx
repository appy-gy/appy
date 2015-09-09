React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

Logo = React.createClass
  displayName: 'Logo'

  contextTypes:
    onLogoClick: PropTypes.func.isRequired

  render: ->
    {onLogoClick} = @context

    <Link to="root" className="header_logotype" onClick={onLogoClick}>
    </Link>

module.exports = Logo
