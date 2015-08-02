React = require 'react/addons'
Marty = require 'marty'
Popup = require '../../models/popup'
SettingsPopup = require './settings_popup'

{PropTypes} = React

Settings = React.createClass
  displayName: 'Settings'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    user: PropTypes.object.isRequired

  showPopup: ->
    {user} = @context

    popup = new Popup
      type: 'userSettings'
      content: <SettingsPopup app={@app} user={user}/>

    @app.popupsActions.append popup

  render: ->
    <div className="user-profile_settings" onClick={@showPopup}>
    </div>

module.exports = Settings
