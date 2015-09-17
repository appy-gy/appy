React = require 'react'

{PropTypes} = React

Main = React.createClass
  displayName: 'Main'

  propTypes:
    children: PropTypes.node.isRequired

  render: ->
    {children} = @props

    <main className="layout_main">
      <div className='grid'>
        {children}
      </div>
    </main>

module.exports = Main
