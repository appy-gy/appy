React = require 'react'
ReactRedux = require 'react-redux'
AuthPopupButton = require '../../mixins/auth_popup_button'

{connect} = ReactRedux

Registration = React.createClass
  displayName: 'Registration'

  mixins: [AuthPopupButton]

  submitAction: 'register'
  popupTitle: 'Регистрация'
  switcherComponent: 'login'
  switcherContent: 'Войти'

  failToastContent: (error) ->
    error

module.exports = connect()(Registration)
