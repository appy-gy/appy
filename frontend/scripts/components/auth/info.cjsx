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

    <Link className="auth_user-profile-link" to="user" params={{userId: user.id}}>
      <img className="auth_user-avatar" width="50" height="50" src={user.avatarUrl('small')}/>
      <div className="auth_user-name">
        {user.name or user.email}
      </div>
    </Link>

module.exports = Info
