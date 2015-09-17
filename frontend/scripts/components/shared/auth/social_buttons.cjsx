_ = require 'lodash'
React = require 'react'
SocialButton = require './social_button'

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  buttons: [
    { provider: 'facebook', text: 'Facebook' }
    { provider: 'vk', text: 'Вконтакте' }
    # { provider: 'twitter', text: 'Twitter' }
    # { provider: 'google', text: 'Google' }
  ]

  auth: (provider) ->
    window.location = "/oauth/#{provider}"

  render: ->
    buttons = @buttons.map ({provider, text}) =>
      onClick = _.partial @auth, provider
      <SocialButton key={provider} provider={provider} text={text} onClick={onClick}/>

    <div className="auth-popup_social-buttons">
      {buttons}
    </div>

module.exports = SocialButtons
