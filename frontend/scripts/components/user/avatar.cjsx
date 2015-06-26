React = require 'react/addons'
Marty = require 'marty'
FileInput = require '../shared/file_input'

{PropTypes} = React

Avatar = React.createClass
  displayName: 'Avatar'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    user: PropTypes.object.isRequired

  componentWillMount: ->
    @fileInputFns = {}

  updateAvatar: (files) ->
    {user} = @context

    avatar = files[0]
    return unless avatar?

    @app.usersActions.change user.id, avatar: avatar.preview
    @app.usersActions.update user.id, { avatar }

  openSelect: ->
    @fileInputFns.open()

  fileInput: ->
    {user} = @context

    return unless user.canEdit

    <div className="user-profile_avatar-edit" onClick={@openSelect}>
      Изменить фотографию профиля
    </div>

  render: ->
    {user} = @context

    imageStyles = backgroundImage: "url(#{user.avatarUrl('normal')})"

    <FileInput ref="input" className="user-profile_avatar" utilFns={@fileInputFns} onSelect={@updateAvatar}>
      <div className="user-profile_avatar-img" style={imageStyles}></div>
      {@fileInput()}
    </FileInput>

module.exports = Avatar
