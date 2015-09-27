React = require 'react'
classNames = require 'classnames'

{PropTypes} = React

Main = React.createClass
  displayName: 'Main'

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    headerExpanded: PropTypes.bool.isRequired

  render: ->
    {children} = @props
    {headerExpanded} = @context

    classes = classNames 'layout_main', 'm-header-expanded': headerExpanded

    <main className={classes}>
      <div className='grid'>
        {children}
      </div>
    </main>

module.exports = Main
