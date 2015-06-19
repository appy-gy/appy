React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Tags = React.createClass
  displayName: 'Tags'

  mixins: [PureRenderMixin]

  propTypes:
    tag: PropTypes.object.isRequired

  render: ->
    {tag} = @props

    <span className="tag">
      {tag.name}
    </span>

module.exports = Tags
