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
      {children}
    </header>

module.exports = Header
