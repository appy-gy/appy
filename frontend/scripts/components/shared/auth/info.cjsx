React = require 'react/addons'
UserLink = require '../links/user'

{PropTypes} = React

Info = React.createClass
  displayName: 'Info'

  propTypes:
    user: PropTypes.object.isRequired

  contextTypes:
    block: PropTypes.string.isRequired

  render: ->
    {user} = @props
    {block} = @context

    <UserLink className="#{block}_user-profile-link" user={user}>
      <img className="#{block}_user-avatar" width="50" height="50" src={user.avatarUrl('small')}/>
      <div className="#{block}_user-name">
        {user.name or user.email}
      </div>
    </UserLink>
module.exports = Info
