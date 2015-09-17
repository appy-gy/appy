React = require 'react'

{PropTypes} = React

MetaItem = React.createClass
  displayName: 'MetaItem'

  contextTypes:
    block: PropTypes.string.isRequired

  propTypes: ->
    icon: PropTypes.string
    children: PropTypes.node.isRequired

  icon: ->
    {icon} = @props
    {block} = @context

    return unless icon?

    <div className="#{block}_icon m-#{icon}"></div>

  render: ->
    {children} = @props
    {block} = @context

    <div className="#{block}_item">
      {@icon()}
      <div ref="content" className="#{block}_text">
        {children}
      </div>
    </div>

module.exports = MetaItem
