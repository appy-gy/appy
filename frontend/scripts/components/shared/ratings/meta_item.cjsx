React = require 'react'

{PropTypes} = React

MetaItem = React.createClass
  displayName: 'MetaItem'

  contextTypes:
    block: PropTypes.string.isRequired

  propTypes: ->
    icon: PropTypes.string
    anchor: PropTypes.string
    children: PropTypes.node.isRequired

  getDefaultProps: ->
    icon: null
    anchor: null

  icon: ->
    {icon} = @props
    {block} = @context

    return unless icon?

    <div className="#{block}_icon m-#{icon}"></div>

  render: ->
    {anchor, children} = @props
    {block} = @context

    Root = if anchor? then 'a' else 'div'

    <Root href="##{anchor}" className="#{block}_item" data-scroll data-options='{"updateURL": true}'>
      {@icon()}
      <div ref="content" className="#{block}_text">
        {children}
      </div>
    </Root>

module.exports = MetaItem
