React = require 'react/addons'
Marty = require 'marty'
AppFromProps = require '../../mixins/app_from_props'
AppToContext = require '../../mixins/app_to_context'
Title = require './title'
SocialButtons = require './social_buttons'
Or = require './or'
AuthForm = require './auth_form'
ResetPassword = require './reset_password'

{PropTypes} = React

AuthPopup = React.createClass
  displayName: 'AuthPopup'

  mixins: [AppFromProps, AppToContext]

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
      <ResetPassword/>
    </div>

module.exports = AuthPopup
