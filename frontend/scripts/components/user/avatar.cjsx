React = require 'react/addons'
Marty = require 'marty'
WithFileInput = require '../mixins/with_file_input'
WithRequestQueue = require '../mixins/with_request_queue'
FileInput = require '../shared/file_input'
withIndexKeys = require '../../helpers/react/with_index_keys'

{PropTypes} = React

Avatar = React.createClass
  displayName: 'Avatar'

  mixins: [Marty.createAppMixin(), WithFileInput, WithRequestQueue]

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  updateAvatar: (files) ->
    {user} = @context

    avatar = files[0]
    return unless avatar?

    @app.usersActions.change user.id, avatar: avatar.preview
    @clearQueue()
    @addToQueue =>
      @app.usersActions.update user.id, { avatar }

  fileInput: ->
    {canEdit} = @context

    return unless canEdit

    <div className="user-profile_avatar-edit" onClick={@openSelect}>
      Изменить фотографию профиля
    </div>

  children: ->
    {user} = @context

    imageStyles = backgroundImage: "url(#{user.avatarUrl('normal')})"

    withIndexKeys [
      <div className="user-profile_avatar-img" style={imageStyles}></div>
      @fileInput()
    ]

  render: ->
    {canEdit} = @context

    classes = 'user-profile_avatar'

    return <div className={classes}>{@children()}</div> unless canEdit

    <FileInput className={classes} onSelect={@updateAvatar} {...@fileInputProps()}>
      {@children()}
    </FileInput>

module.exports = Avatar
