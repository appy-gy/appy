React = require 'react/addons'
Marty = require 'marty'
AuthPopupButton = require '../../mixins/auth_popup_button'

Registration = React.createClass
  displayName: 'Registration'

  mixins: [Marty.createAppMixin(), AuthPopupButton]

  submitAction: 'register'
  popupTitle: 'Регистрация'
  switcherComponent: 'login'
  switcherContent: 'Войти'

  failToastContent: (error) ->
    error

module.exports = Registration
