React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserActionCreators = require '../../action_creators/current_user'
PopupsStore = require '../../stores/popups'

{PureRenderMixin} = React.addons

Registration = React.createClass
  displayName: 'Registration'

  mixins: [PureRenderMixin]

  register: (data) ->
    CurrentUserActionCreators.register data
      .then (user) =>
        return unless user?.isLoggedIn()
        @closePopup()

  showPopup: ->
    PopupsStore.append @popup()

  closePopup: ->
    PopupsStore.remove @popup()

  popup: ->
    @popupCache ||= <AuthPopup title="Регистрация" onSubmit={@register} onClose={@closePopup}/>

  render: ->

    <div className="auth_registration" onClick={@showPopup}>
      Регистрация
    </div>

module.exports = Registration
