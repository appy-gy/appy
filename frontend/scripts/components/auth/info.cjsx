React = require 'react/addons'
UserLink = require '../shared/links/user'

{PropTypes} = React

Info = React.createClass
  displayName: 'Info'

  propTypes:
    user: PropTypes.object.isRequired

  render: ->
    {user} = @props

    <UserLink user={user}>
      <img width="50" height="50" src={user.avatarUrl('small')}/>
      {user.name or user.email}
    </UserLink>

module.exports = Info
