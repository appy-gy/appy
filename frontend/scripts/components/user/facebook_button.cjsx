React = require 'react/addons'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

FacebookButton = React.createClass
  displayName: 'FacebookButton'

  contextTypes:
    user: PropTypes.object.isRequired
    edit: PropTypes.bool.isRequired

  getFacebookLink: (event) ->
    {user, edit} = @context

    return unless edit

    event.preventDefault()

    FB.login ({status}) ->
      return unless status == 'connected'
      FB.api '/me', fields: 'link', ({link}) ->
        UserActionCreators.change user.id, facebookLink: link

  render: ->
    {user} = @context
    <div>
      <div className="user-profile_social m-add">
        <a className="user-profile_social-button m-fb" target="_blank"></a>
        <a href={user.facebookLink} target="_blank"  onClick={@getFacebookLink} className="user-profile_social-link">Привязать</a>
      </div>
      <div className="user-profile_social m-remove">
        <a className="user-profile_social-button m-fb" target="_blank"></a>
        <span className="user-profile_social-caption">Привязано</span>
        <a className="user-profile_social-link">Отвязать</a>
      </div>
    </div>

module.exports = FacebookButton
