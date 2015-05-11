React = require 'react/addons'
UserLink = require '../shared/links/user'

{PropTypes} = React

Info = React.createClass
  displayName: 'Info'

  propTypes:
    user: PropTypes.object.isRequired

  render: ->
    {user} = @props

    <UserLink className="auth_user-profile-link" user={user}>
      <img className="auth_user-avatar" width="50" height="50" src={user.avatarUrl('small')}/>
      <div className="auth_user-name">
        {user.name or user.email}
      </div>
    </UserLink>
module.exports = Info
