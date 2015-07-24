React = require 'react/addons'
Marty = require 'marty'
Title = require './title'
Close = require './close'
SocialButtons = require './social_buttons'
Or = require './or'
Form = require './form'

{PropTypes} = React

AuthPopup = React.createClass
  displayName: 'AuthPopup'

  propTypes:
    title: PropTypes.string.isRequired
    onSubmit: PropTypes.func.isRequired
    onClose: PropTypes.func.isRequired
    switcher: PropTypes.node.isRequired

  render: ->
    {title, onSubmit, onClose, switcher} = @props

    <div className="auth-popup">
      <Title text={title}/>
      <Close onClick={onClose}/>
      <SocialButtons/>
      <Or/>
      <Form ref="form" onSubmit={onSubmit}/>
      {switcher}
    </div>

module.exports = AuthPopup
