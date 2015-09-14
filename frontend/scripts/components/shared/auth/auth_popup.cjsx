React = require 'react/addons'
Title = require './title'
SocialButtons = require './social_buttons'
Or = require './or'
AuthForm = require './auth_form'
ResetPassword = require './reset_password'

{PropTypes} = React

AuthPopup = React.createClass
  displayName: 'AuthPopup'

  propTypes:
    title: PropTypes.string.isRequired
    onSubmit: PropTypes.func.isRequired
    switcher: PropTypes.node.isRequired

  render: ->
    {title, onSubmit, switcher} = @props

    <div className="auth-popup">
      <Title text={title}/>
      <SocialButtons/>
      <Or/>
      <AuthForm ref="form" onSubmit={onSubmit}/>
      {switcher}
      <ResetPassword className="auth-popup_link"/>
    </div>

module.exports = AuthPopup
