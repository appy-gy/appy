React = require 'react/addons'
FacebookButton = require './facebook_button'

SocialButtons = React.createClass
  displayName: 'SocialButtons'

  render: ->
    <div className="user-profile_socials">
      <FacebookButton/>
      <div className="user-profile_social m-insta">
      </div>
    </div>

module.exports = SocialButtons
