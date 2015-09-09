React = require 'react/addons'
classNames = require 'classnames'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

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
      <div className="header_menu-button-wrap" onClick={@triggerExpand}>
        <div className="header_menu-button"></div>
      </div>
      <div className="header_content">
        {children}
      </div>
    </header>

module.exports = Header
