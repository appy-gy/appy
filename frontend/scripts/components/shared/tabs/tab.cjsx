React = require 'react'

{PropTypes} = React

Tab = React.createClass
  displayName: 'Tab'

  PropTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_tab">
      {children}
    </div>

module.exports = Tab
