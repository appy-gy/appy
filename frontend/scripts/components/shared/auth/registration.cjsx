React = require 'react/addons'
Marty = require 'marty'
AuthPopup = require './auth_popup'
Popup = require '../../../models/popup'
Toast = require '../../../models/toast'

{PropTypes} = React

Registration = React.createClass
  displayName: 'Registration'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    block: PropTypes.string.isRequired

  register: (data) ->
    @app.currentUserActions.register data
      .then ({error}) =>
        return @showFailToast error if error?
        @closePopup()

  showPopup: ->
    @app.popupsActions.append @popup()

  closePopup: ->
    @app.popupsActions.remove @popup()

  popup: ->
    @popupCache ||= new Popup <AuthPopup title="Регистрация" onSubmit={@register} onClose={@closePopup}/>

  showFailToast: (error) ->
    toast = new Toast error, type: 'error'
    @app.toastsActions.append toast

  render: ->
    {block} = @context

    <div className="#{block}_registration" onClick={@showPopup}>
      Регистрация
    </div>

module.exports = Registration
