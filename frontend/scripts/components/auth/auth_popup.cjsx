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
    title: PropTypes.string.isRequired
    onSubmit: PropTypes.func.isRequired
    onClose: PropTypes.func.isRequired

  render: ->
    {title, onSubmit, onClose} = @props

    <div className="auth-popup">
      <Title text={title}/>
      <Close onClick={onClose}/>
      <SocialButtons/>
      <Or/>
      <Form onSubmit={onSubmit}/>
    </div>

module.exports = AuthPopup
