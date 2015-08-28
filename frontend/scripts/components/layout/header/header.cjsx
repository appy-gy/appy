React = require 'react/addons'
classNames = require 'classnames'

{PropTypes} = React
{PureRenderMixin} = React.addons

Header = React.createClass
  displayName: 'Header'

  mixins: [PureRenderMixin]

  propTypes:
    children: PropTypes.node.isRequired

  getInitialState: ->
    expanded: false

  triggerExpand: ->
    {expanded} = @state

    @setState expanded: not expanded

  render: ->
    {children} = @props
    {expanded} = @state

    classes = classNames 'layout_header', 'header', 'm-active': expanded

    <header className={classes}>
      <div className="header_menu-button" onClick={@triggerExpand}></div>
      <div className="header_content">
        {children}
      </div>
    </header>

module.exports = Header
