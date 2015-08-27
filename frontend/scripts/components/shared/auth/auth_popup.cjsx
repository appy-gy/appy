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
    showSocial = false

    <div className="auth-popup">
      <Title text={title}/>
      { <SocialButtons/> if showSocial }
      { <Or/> if showSocial }
      <AuthForm ref="form" onSubmit={onSubmit}/>
      {switcher}
      <ResetPassword className="auth-popup_link"/>
    </div>

module.exports = AuthPopup
