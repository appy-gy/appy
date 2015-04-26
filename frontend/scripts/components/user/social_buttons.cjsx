React = require 'react/addons'
FacebookButton = require './facebook_button'
InstagramButton = require './instagram_button'

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  render: ->
    <div className="user-profile_socials">
      <FacebookButton/>
      <InstagramButton/>
    </div>

module.exports = SocialButtons
