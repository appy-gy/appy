React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

Section = React.createClass
  displayName: 'Section'

  propTypes:
    section: PropTypes.object.isRequired

  render: ->
    {section} = @props

    styles = background: section.color

    <Link to="section" params={sectionSlug: section.slug} className="site-nav_item" style={styles}>
      <div className="site-nav_icon"></div>
      <div className="site-nav_text">{section.name}</div>
    </Link>

module.exports = Section
