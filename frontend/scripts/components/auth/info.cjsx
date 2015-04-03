React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{PureRenderMixin} = React.addons
{Link} = Router

Info = React.createClass
  displayName: 'Info'

  mixins: [PureRenderMixin]

  propTypes:
    user: PropTypes.object.isRequired

  render: ->
    {user} = @props

    <Link to="user" params={{userId: user.id}}>
      <img width="50" height="50" src={user.avatarUrl('small')}/>
      {user.name or user.email}
    </Link>

module.exports = Info
