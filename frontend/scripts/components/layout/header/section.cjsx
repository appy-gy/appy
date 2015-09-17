React = require 'react'
SectionLink = require '../../shared/links/section'

{PropTypes} = React

Section = React.createClass
  displayName: 'Section'

  propTypes:
    section: PropTypes.object.isRequired

  render: ->
    {section} = @props

    styles = background: section.color

    <SectionLink section={section} className="site-nav_item" style={styles}>
      <div className="site-nav_icon"></div>
      <div className="site-nav_text">{section.name}</div>
    </SectionLink>

module.exports = Section
