React = require 'react/addons'

# .navigation_item style="background-color: #{section.color}"
#   img src="//placehold.it/40x30"
#   div = section.name
Section = React.createClass
  render: ->
    {section} = @props

    styles = background: section.color

    <div className="navigation_item" style={styles}>
      <img src="//placehold.it/40x30"/>
      <div>{section.name}</div>
    </div>

module.exports = Section
