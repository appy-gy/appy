React = require 'react/addons'
AuthPopup = require './auth_popup'
CurrentUserActionCreators = require '../../action_creators/current_user'
PopupActionCreators = require '../../action_creators/popups'
Popup = require '../../models/popup'
ToastActionCreators = require '../../action_creators/toasts'
Toast = require '../../models/toast'

{PureRenderMixin} = React.addons

Registration = React.createClass
  displayName: 'Registration'

  mixins: [PureRenderMixin]

  register: (data) ->
    CurrentUserActionCreators.register data
      .then ({error}) =>
        return @showFailToast error if error?
        @closePopup()

  showPopup: ->
    PopupActionCreators.append @popup()

  closePopup: ->
    PopupActionCreators.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Регистрация" onSubmit={@register} onClose={@closePopup}/>

  showFailToast: (error) ->
    toast = new Toast error, type: 'error'
    ToastActionCreators.append toast

  render: ->
    <div className="auth_registration" onClick={@showPopup}>
      Регистрация
    </div>

module.exports = Registration
