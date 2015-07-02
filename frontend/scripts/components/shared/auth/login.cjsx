React = require 'react/addons'
Marty = require 'marty'
Classes = require '../../mixins/classes'
AuthPopup = require './auth_popup'
Popup = require '../../../models/popup'
Toast = require '../../../models/toast'

{PropTypes} = React

Login = React.createClass
  displayName: 'Login'

  mixins: [Marty.createAppMixin(), Classes]

  propTypes:
    children: PropTypes.node

  contextTypes:
    block: PropTypes.string.isRequired

  logIn: (data) ->
    @app.currentUserActions.logIn data
      .then ({error}) =>
        return @showFailToast() if error?
        @closePopup()

  showPopup: ->
    @app.popupsActions.append @popup()

  closePopup: ->
    @app.popupsActions.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Вход" onSubmit={@logIn} onClose={@closePopup}/>

  showFailToast: ->
    toast = new Toast 'Неверный логин или пароль', type: 'error'
    @app.toastsActions.append toast

  render: ->
    {children} = @props
    {block} = @context

    <div className={@classes("#{block}_login")} onClick={@showPopup}>
      {children}
    </div>

module.exports = Login
