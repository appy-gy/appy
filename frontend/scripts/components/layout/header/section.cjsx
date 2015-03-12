React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Section = React.createClass
  displayName: 'Section'

  mixins: [PureRenderMixin]

  propTypes:
    section: PropTypes.object.isRequired

  render: ->
    {section} = @props

    styles = background: section.color

    <div className="site-nav_item" style={styles}>
      <div className="site-nav_icon"></div>
      <div className="site-nav_text">{section.name}</div>
    </div>

module.exports = Section
