React = require 'react/addons'
RegistrationForm = require './registration_form'
CurrentUserApi = require '../../state_sources/current_user'
PopupsStore = require '../../stores/popups'

{PureRenderMixin} = React.addons

Registration = React.createClass
  displayName: 'Registration'

  mixins: [PureRenderMixin]

  register: (data) ->
    CurrentUserApi.register data

  showPopup: ->
    PopupsStore.append @popup()

  hidePopup: ->
    PopupsStore.remove @popup()

  popup: ->
    @popupCache ||= <RegistrationForm onSubmit={@register}/>

  render: ->

    <div onClick={@showPopup}>
      Registration
    </div>

module.exports = Registration
