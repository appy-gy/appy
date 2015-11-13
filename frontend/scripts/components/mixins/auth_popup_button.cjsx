# To use this mixin your component should be connected to redux,
# has following fields:
# submitAction, popupTitle, switcherComponent, switcherContent
# and define following methods:
# failToastContent

_ = require 'lodash'
React = require 'react'
currentUserActions = require '../../actions/current_user'
popupActions = require '../../actions/popups'
buildPopup = require '../../helpers/popups/build'
showToast = require '../../helpers/toasts/show'
AuthPopup = require '../shared/auth/auth_popup'
Login = -> require '../shared/auth/login'
Registration = -> require '../shared/auth/registration'

{PropTypes} = React
{appendPopup, removePopupsWithType} = popupActions

AuthPopupButton =
  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  switcherComponents:
    login: Login
    registration: Registration

  submit: (data) ->
    {dispatch} = @props

    dispatch currentUserActions[@submitAction](data)
      .then => @closeAuthPopups()
      .catch (error) => @showFailToast error

  showFailToast: (error) ->
    showToast @props.dispatch, @failToastContent(error), 'error'

  switcher: ->
    Component = @switcherComponents[@switcherComponent]()

    <Component className="auth-popup_link">
      {@switcherContent}
    </Component>

  closeAuthPopups: ->
    @props.dispatch removePopupsWithType('auth')

  showPopup: ->
    {dispatch} = @props

    @closeAuthPopups()

    popup = buildPopup
      type: 'auth'
      content: => <AuthPopup title={@popupTitle} onSubmit={@submit} switcher={@switcher()}/>

    dispatch appendPopup(popup)

  render: ->
    {children} = @props

    props = _.omit @props, 'children'

    <div onClick={@showPopup} {...props}>
      {children}
    </div>

module.exports = AuthPopupButton
