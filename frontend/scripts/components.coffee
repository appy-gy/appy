components =
  Auth:
    Login: require './components/auth/login'
    LoginForm: require './components/auth/login_form'
    Logout: require './components/auth/logout'
    RegForm: require './components/auth/reg_form'
    Registration: require './components/auth/registration'
  Header:
    Auth: require './components/header/auth'
    Logo: require './components/header/logo'
    Navigation: require './components/header/navigation'
    Section: require './components/header/section'
  Layout:
    Header: require './components/layout/header'
  Modal:
    Dialog: require './components/modal/dialog'
  Ratings:
    Preview: require './components/ratings/preview'
    Previews: require './components/ratings/previews'

module.exports = components