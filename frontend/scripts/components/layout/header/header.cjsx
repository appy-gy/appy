React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Header = React.createClass
  displayName: 'Header'

  mixins: [PureRenderMixin]

  propTypes:
    children: PropTypes.node.isRequired

  render: ->
    {children} = @props

    <header className="layout_header header">
      <div className="header_menu-button"></div>
      <div className="header_content">
        {children}
      </div>
    </header>

module.exports = Header
