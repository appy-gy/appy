React = require 'react'
SocialButton = require './social_button'

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  networks: ['facebook', 'instagram']

  buttons: ->
    @networks.map (network) ->
      <SocialButton key={network} network={network}/>

  render: ->
    <div className="user-profile_socials">
      {@buttons()}
    </div>

module.exports = SocialButtons
