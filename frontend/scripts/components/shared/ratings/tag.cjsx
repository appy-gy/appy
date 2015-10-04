React = require 'react'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

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
      <Link to="/tags/#{tag.slug}">
        {tag.name}
      </Link>
    </span>

module.exports = Tags
