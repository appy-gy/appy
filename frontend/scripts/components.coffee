components =
  Auth:
    Box: require './components/auth/box'
    Login: require './components/auth/login'
    LoginForm: require './components/auth/login_form'
    Registration: require './components/auth/registration'
  Ratings:
    Preview: require './components/ratings/preview'
    Previews: require './components/ratings/previews'

module.exports = components