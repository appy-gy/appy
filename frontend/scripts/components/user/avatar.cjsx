React = require 'react/addons'
Marty = require 'marty'
FileInput = require '../shared/file_input'

{PropTypes} = React

Avatar = React.createClass
  displayName: 'Avatar'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    user: PropTypes.object.isRequired

  updateAvatar: (files) ->
    {user} = @context

    avatar = files[0]
    return unless avatar?

    url = URL.createObjectURL avatar

    @app.usersActions.change user.id, avatar: url
    @app.usersActions.update user.id, { avatar }

  fileInput: ->
    {user} = @context

    return unless user.canEdit

    <FileInput className="user-profile_avatar-edit" onChange={@updateAvatar}>
      Изменить фотографию профиля
    </FileInput>

  render: ->
    {user} = @context

    <div className="user-profile_avatar">
      <img className="user-profile_avatar-img" src={user.avatarUrl('normal')}/>
      {@fileInput()}
    </div>

module.exports = Avatar
