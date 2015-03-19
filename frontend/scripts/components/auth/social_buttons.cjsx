_ = require 'lodash'
React = require 'react/addons'
SocialButton = require './social_button'

{PropTypes} = React
{PureRenderMixin} = React.addons

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  mixins: [PureRenderMixin]

  propTypes:
    onClick: PropTypes.func.isRequired

  buttons: [
    { provider: 'facebook', text: 'Facebook' }
    { provider: 'vkontakte', text: 'Вконтакте' }
    { provider: 'twitter', text: 'Twitter' }
    { provider: 'google', text: 'Google' }
  ]

  render: ->
    {onClick} = @props

    buttons = @buttons.map ({provider, text}) ->
      onCl = _.partial onClick, provider
      <SocialButton key={provider} provider={provider} text={text} onClick={onCl}/>

    <div className="auth-popup_social-buttons">
      {buttons}
    </div>

module.exports = SocialButtons
