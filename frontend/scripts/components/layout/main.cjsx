React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

Main = React.createClass
  displayName: 'Main'

  propTypes:
    hasHeader: PropTypes.bool.isRequired
    isBlured: PropTypes.bool.isRequired
    children: PropTypes.node

  contextTypes:
    headerExpanded: PropTypes.bool.isRequired

  getDefaultProps: ->
    children: null

  render: ->
    {hasHeader, isBlured, children} = @props
    {headerExpanded} = @context

    classes = classNames 'layout_main',
      'm-without-header': not hasHeader,
      'm-header-expanded': headerExpanded,
      'm-blured': isBlured

    <main className={classes}>
      <div className='grid'>
        {children}
      </div>
    </main>

module.exports = Main
