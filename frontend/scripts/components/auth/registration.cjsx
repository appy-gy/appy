React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserApi = require '../../state_sources/current_user'
PopupsStore = require '../../stores/popups'

{PureRenderMixin} = React.addons

Registration = React.createClass
  displayName: 'Registration'

  mixins: [PureRenderMixin]

  socialRegister: (type) ->
    console.log 'social register', type

  register: (data) ->
    CurrentUserApi.register data

  showPopup: ->
    PopupsStore.append @popup()

  closePopup: ->
    PopupsStore.remove @popup()

  popup: ->
    @popupCache ||= <AuthPopup title="Регистрация" onSocialSubmit={@socialRegister} onSubmit={@register} onClose={@closePopup}/>

  render: ->

    <div onClick={@showPopup}>
      Регистрация
    </div>

module.exports = Registration
