React = require 'react/addons'

{PropTypes} = React

Main = React.createClass
  displayName: 'Main'

  propTypes:
    children: PropTypes.node.isRequired

  render: ->
    {children, sectionSlug} = @props

    <main className="layout_main section_#{sectionSlug}">
      <div className='grid'>
        {children}
      </div>
    </main>

module.exports = Main
