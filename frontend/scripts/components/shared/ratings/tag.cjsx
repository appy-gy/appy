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

    <Link className="#{block}_tag tag" to="/tags/#{tag.slug}">
      {tag.name}
    </Link>

module.exports = Tags
