React = require 'react'

{PropTypes} = React

Tags = React.createClass
  displayName: 'Tags'

  propTypes:
    tag: PropTypes.object.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  render: ->
    {tag} = @props
    {block} = @context

    <span className="#{block}_tag tag">
      {tag.name}
    </span>

module.exports = Tags
