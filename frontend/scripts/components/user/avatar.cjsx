React = require 'react/addons'
FileInput = require '../shared/file_input'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

Avatar = React.createClass
  displayName: 'Avatar'

  contextTypes:
    user: PropTypes.object.isRequired

  updateAvatar: (files) ->
    {user} = @context

    avatar = files[0]
    return unless avatar?

    url = URL.createObjectURL avatar

    UserActionCreators.change user.id, avatar: url
    UserActionCreators.update user.id, { avatar }

  render: ->
    {user} = @context

    <div className="user-profile_avatar">
      <img className="user-profile_avatar-img" src={user.avatarUrl('normal')}/>
      <FileInput className="user-profile_avatar-edit" onChange={@updateAvatar}>
        Изменить фотографию профиля
      </FileInput>
    </div>

module.exports = Avatar
