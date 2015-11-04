React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  propTypes:
    isBlured: PropTypes.bool.isRequired
    children: PropTypes.node.isRequired

  contextTypes:
    headerExpanded: PropTypes.bool.isRequired
    triggerHeader: PropTypes.func.isRequired

  render: ->
    {isBlured, children} = @props
    {headerExpanded, triggerHeader} = @context

    classes = classNames 'layout_header', 'header', 'm-active': headerExpanded, 'm-blured': isBlured

    <header className={classes} onClick={triggerHeader}>
      <div className="header_menu-button-wrap">
        <div className="header_menu-button"></div>
      </div>
      <div className="header_content">
        {children}
      </div>
    </header>

module.exports = Header
