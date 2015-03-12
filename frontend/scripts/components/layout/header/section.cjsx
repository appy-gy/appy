React = require 'react/addons'

# .navigation_item style="background-color: #{section.color}"
#   img src="//placehold.it/40x30"
#   div = section.name
Section = React.createClass
  render: ->
    {section} = @props

    styles = background: section.color

    <div className="site-nav_item" style={styles}>
      <div className="site-nav_icon"></div>
      <div className="site-nav_text">{section.name}</div>
    </div>

module.exports = Section
