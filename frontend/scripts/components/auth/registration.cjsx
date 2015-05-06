React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserActionCreators = require '../../action_creators/current_user'
PopupActionCreators = require '../../action_creators/popups'
Popup = require '../../models/popup'

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
    PopupActionCreators.append @popup()

  closePopup: ->
    PopupActionCreators.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Регистрация" onSubmit={@register} onClose={@closePopup}/>

  render: ->

    <div className="auth_registration" onClick={@showPopup}>
      Регистрация
    </div>

module.exports = Registration
