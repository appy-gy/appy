React = require 'react/addons'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

FacebookButton = React.createClass
  displayName: 'FacebookButton'

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  getFacebookId: (event) ->
    {user, edit} = @context

    return unless edit

    event.preventDefault()

    FB.login ({status}) ->
      return unless status == 'connected'
      FB.api '/me', fields: 'link', ({link}) ->
        UserActionCreators.change user.id, facebookLink: link

  render: ->
    {user} = @context

    <a href={user.facebookLink} target="_blank" className="user-profile_social m-fb" onClick={@getFacebookId}></a>

module.exports = FacebookButton
