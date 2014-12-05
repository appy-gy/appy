components =
  Auth:
    Box: require './components/auth/box'
    Login: require './components/auth/login'
    LoginForm: require './components/auth/login_form'
    Logout: require './components/auth/logout'
    RegForm: require './components/auth/reg_form'
    Registration: require './components/auth/registration'
  Dialog:
    Modal: require './components/dialog/modal'
  Ratings:
    Preview: require './components/ratings/preview'
    Previews: require './components/ratings/previews'

module.exports = components