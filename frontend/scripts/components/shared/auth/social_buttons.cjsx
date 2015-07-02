_ = require 'lodash'
React = require 'react/addons'
SocialButton = require './social_button'

{PureRenderMixin} = React.addons

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  mixins: [PureRenderMixin]

  buttons: [
    { provider: 'facebook', text: 'Facebook' }
    { provider: 'vk', text: 'Вконтакте' }
    { provider: 'twitter', text: 'Twitter' }
    { provider: 'google', text: 'Google' }
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
