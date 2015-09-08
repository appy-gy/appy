_ = require 'lodash'
React = require 'react/addons'
buildPopup = require '../../helpers/popups/build'
showToast = require '../../helpers/toasts/show'
AppFromProps = require './app_from_props'
AuthPopup = require '../shared/auth/auth_popup'
Login = -> require '../shared/auth/login'
Registration = -> require '../shared/auth/registration'

{PropTypes} = React

AuthPopupButton =
  mixins: [AppFromProps]

  propTypes:
    children: PropTypes.node.isRequired
    onSuccess: PropTypes.func

  switcherComponents:
    login: Login
    registration: Registration

  getDefaultProps: ->
    onSuccess: ->

  submit: (data) ->
    {onSuccess} = @props

    @app.currentUserActions[@submitAction] data
      .then ({error}) =>
        return @showFailToast(error) if error?
        @closeAuthPopups()
        onSuccess()

  showFailToast: (error) ->
    showToast @app, @failToastContent(error), 'error'

  switcher: ->
    Component = @switcherComponents[@switcherComponent]()

    <Component app={@app} className="auth-popup_link">
      {@switcherContent}
    </Component>

  closeAuthPopups: ->
    popups = @app.popupsStore.getOfType('auth')
    @app.popupsActions.remove popups

  showPopup: ->
    @closeAuthPopups()

    popup = buildPopup
      type: 'auth'
      content: <AuthPopup app={@app} title={@popupTitle} onSubmit={@submit} switcher={@switcher()}/>

    @app.popupsActions.append popup

  render: ->
    {children} = @props

    props = _.omit @props, 'children'

    <div onClick={@showPopup} {...props}>
      {children}
    </div>

module.exports = AuthPopupButton
