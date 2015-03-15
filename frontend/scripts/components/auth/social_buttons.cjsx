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
    { type: 'facebook', text: 'Facebook' }
    { type: 'vkontakte', text: 'Вконтакте' }
    { type: 'twitter', text: 'Twitter' }
    { type: 'google', text: 'Google' }
  ]

  render: ->
    {onClick} = @props

    buttons = @buttons.map ({type, text, color}) ->
      onCl = _.partial onClick, type
      <SocialButton key={type} type={type} text={text} onClick={onCl}/>

    <div className="auth-popup_social-buttons">
      {buttons}
    </div>

module.exports = SocialButtons
