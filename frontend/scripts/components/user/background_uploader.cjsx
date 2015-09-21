React = require 'react'
ReactRedux = require 'react-redux'
userActions = require '../../actions/user'
imageUrl = require '../../helpers/image_url'
WithFileInput = require '../mixins/with_file_input'
WithRequestQueue = require '../mixins/with_request_queue'

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

  render: ->
    <div className="user-profile_background-uploader">
    </div>

module.exports = connect()(BackgroundUploader)
