React = require 'react/addons'
Marty = require 'marty'
AuthPopupButton = require '../../mixins/auth_popup_button'

Login = React.createClass
  displayName: 'Login'

  mixins: [Marty.createAppMixin(), AuthPopupButton]

  submitAction: 'logIn'
  popupTitle: 'Войти'
  switcherComponent: 'registration'
  switcherContent: 'Зарегистрироваться'

  failToastContent: ->
    'Неверный логин или пароль'

module.exports = Login
