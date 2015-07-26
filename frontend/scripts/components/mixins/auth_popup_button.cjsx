_ = require 'lodash'
React = require 'react/addons'
AuthPopup = require '../shared/auth/auth_popup'
Login = -> require '../shared/auth/login'
Registration = -> require '../shared/auth/registration'
Popup = require '../../models/popup'

{PropTypes} = React

AuthPopupButton =
  propTypes:
    children: PropTypes.node.isRequired

  switcherComponents:
    login: Login
    registration: Registration

  componentWillMount: ->
    {app} = @props

    @app ||= app

  submit: (data) ->
    @app.currentUserActions[@submitAction] data
      .then ({error}) =>
        return @showFailToast() if error?
        @closeAuthPopups()

  showFailToast: (error) ->
    toast = new Toast @failToastContent(error), type: 'error'
    @app.toastsActions.append toast

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

    popup = new Popup
      type: 'auth'
      content: <AuthPopup title={@popupTitle} onSubmit={@submit} switcher={@switcher()}/>

    @app.popupsActions.append popup

  render: ->
    {children} = @props

    props = _.omit @props, 'children'

    <div onClick={@showPopup} {...props}>
      {children}
    </div>

module.exports = AuthPopupButton
