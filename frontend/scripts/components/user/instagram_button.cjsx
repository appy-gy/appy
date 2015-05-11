React = require 'react/addons'

{PropTypes} = React

InstagramButton = React.createClass
  displayName: 'InstagramButton'

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  getInstagranLink: (event) ->
    {user, edit} = @context

    return unless edit

    event.preventDefault()

    clientId = process.env.TOP_INSTAGRAM_KEY
    redirectUri = "#{location.origin}/instagram"
    window.location = "https://instagram.com/oauth/authorize/?client_id=#{clientId}&redirect_uri=#{redirectUri}&response_type=token"

  render: ->
    {user} = @context

    <a href={user.instagramLink} target="_blank" className="user-profile_social m-insta" onClick={@getInstagranLink}></a>

module.exports = InstagramButton
