React = require 'react/addons'
Title = require './title'
Close = require './close'
SocialButtons = require './social_buttons'
Or = require './or'
Form = require './form'

{PropTypes} = React
{PureRenderMixin} = React.addons

AuthPopup = React.createClass
  displayName: 'AuthPopup'

  mixins: [PureRenderMixin]

  propTypes:
    onSocialSubmit: PropTypes.func.isRequired
    onSubmit: PropTypes.func.isRequired
    onClose: PropTypes.func.isRequired

  getInitialState: ->
    email: ''
    password: ''

  onSubmit: (event) ->
    {onSubmit} = @props
    {email, password} = @state

    event.preventDefault()

    return unless email? and password?
    onSubmit { email, password }

  render: ->
    {onSocialSubmit, onSubmit, onClose} = @props

    <div className="auth-popup">
      <Title text="Вход"/>
      <Close onClick={onClose}/>
      <SocialButtons onClick={onSocialSubmit}/>
      <Or/>
      <Form onSubmit={onSubmit}/>
    </div>

module.exports = AuthPopup
