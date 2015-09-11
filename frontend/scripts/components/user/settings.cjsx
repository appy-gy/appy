React = require 'react/addons'
Marty = require 'marty'
buildPopup = require '../../helpers/popups/build'
SettingsPopup = require './settings_popup'

{PropTypes} = React

Settings = React.createClass
  displayName: 'Settings'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    user: PropTypes.object.isRequired

  showPopup: ->
    {user} = @context

    popup = buildPopup
      type: 'userSettings'
      content: -> <SettingsPopup user={user}/>

    @app.popupsActions.append popup

  render: ->
    <div className="user-profile_settings" title="Настройки" onClick={@showPopup}>
    </div>

module.exports = Settings
