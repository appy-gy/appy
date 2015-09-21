React = require 'react'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
imageUrl = require '../../helpers/image_url'
WithFileInput = require '../mixins/with_file_input'
WithRequestQueue = require '../mixins/with_request_queue'
FileInput = require '../shared/inputs/file'

{PropTypes} = React
{connect} = ReactRedux
{changeUser, updateUser} = userActions

BackgroundUploader = React.createClass
  displayName: 'BackgroundUploader'

  mixins: [WithFileInput, WithRequestQueue]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  imageUrlFor: ({context}) ->
    imageUrl context.user.background, 'normal'

  updateBackground: (files) ->
    {dispatch} = @props

    background = files[0]
    return unless background?

    dispatch changeUser(background: background.preview)
    @clearQueue()
    @addToQueue ->
      dispatch updateUser({ background })

  render: ->
    <FileInput title="Загрузить бекграунд" className="user-profile_background-uploader" onSelect={@updateBackground} {...@fileInputProps()}>
    </FileInput>

module.exports = connect()(BackgroundUploader)
