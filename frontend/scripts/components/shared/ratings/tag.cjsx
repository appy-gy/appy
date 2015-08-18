React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Tags = React.createClass
  displayName: 'Tags'

  mixins: [PureRenderMixin]

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
