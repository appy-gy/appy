React = require 'react'
ReactRedux = require 'react-redux'
AuthPopupButton = require '../../mixins/auth_popup_button'

{connect} = ReactRedux

Login = React.createClass
  displayName: 'Login'

  mixins: [AuthPopupButton]

  submitAction: 'logIn'
  popupTitle: 'Войти'
  switcherComponent: 'registration'
  switcherContent: 'Зарегистрироваться'

  failToastContent: ->
    'Неверный логин или пароль'

module.exports = connect()(Login)
