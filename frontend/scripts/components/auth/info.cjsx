React = require 'react/addons'

{PropTypes} = React
{PureRenderMixin} = React.addons

Info = React.createClass
  displayName: 'Info'

  mixins: [PureRenderMixin]

  propTypes:
    user: PropTypes.object.isRequired

  render: ->
    {user} = @props

    <div>
      {user.name or user.email}
    </div>

module.exports = Info
