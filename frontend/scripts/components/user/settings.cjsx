React = require 'react/addons'
ReactRedux = require 'react-redux'
popupActions = require '../../actions/popups'
buildPopup = require '../../helpers/popups/build'
SettingsPopup = require './settings_popup'

{PropTypes} = React
{connect} = ReactRedux
{appendPopup} = popupActions

Settings = React.createClass
  displayName: 'Settings'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  showPopup: ->
    {dispatch} = @props
    {user} = @context

    popup = buildPopup
      type: 'userSettings'
      content: -> <SettingsPopup user={user}/>

    dispatch appendPopup(popup)

  render: ->
    <div className="user-profile_settings" title="Настройки" onClick={@showPopup}>
    </div>

module.exports = connect()(Settings)
