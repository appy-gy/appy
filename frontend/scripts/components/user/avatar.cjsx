React = require 'react'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
imageUrl = require '../../helpers/image_url'
withIndexKeys = require '../../helpers/react/with_index_keys'
WithFileInput = require '../mixins/with_file_input'
WithRequestQueue = require '../mixins/with_request_queue'
FileInput = require '../shared/inputs/file'

{PropTypes} = React
{connect} = ReactRedux
{changeUser, updateUser} = userActions

Avatar = React.createClass
  displayName: 'Avatar'

  mixins: [WithFileInput, WithRequestQueue]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  imageUrlFor: ({context}) ->
    imageUrl context.user.avatar, 'normal'

  updateAvatar: (files) ->
    {dispatch} = @props

    avatar = files[0]
    return unless avatar?

    dispatch changeUser(avatar: avatar.preview)
    @clearQueue()
    @addToQueue ->
      dispatch updateUser({ avatar })

  fileInput: ->
    {canEdit} = @context

    return unless canEdit

    <div className="user-profile_avatar-edit" onClick={@openSelect}>
      Изменить фотографию профиля
    </div>

  children: ->
    {user} = @context

    imageStyles = backgroundImage: "url(#{@imageUrl()})"

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

module.exports = connect()(Avatar)
