React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

Header = React.createClass
  displayName: 'Header'

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    headerExpanded: PropTypes.bool.isRequired
    triggerHeader: PropTypes.func.isRequired
    searchVisible: PropTypes.bool.isRequired

  render: ->
    {children} = @props
    {headerExpanded, triggerHeader, searchVisible} = @context

    classes = classNames 'layout_header', 'header', 'm-active': headerExpanded, 'm-blured': searchVisible

    <header className={classes}>
      <div className="header_menu-button-wrap" onClick={triggerHeader}>
        <div className="header_menu-button"></div>
      </div>
      <div className="header_content">
        {children}
      </div>
    </header>

module.exports = Header
