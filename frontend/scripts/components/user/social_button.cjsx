_ = require 'lodash'
React = require 'react/addons'
classNames = require 'classnames'
UserActionCreators = require '../../action_creators/users'

{PropTypes} = React

SocialButton = React.createClass
  displayName: 'SocialButton'

  propTypes:
    network: PropTypes.string.isRequired

  contextTypes:
    user: PropTypes.object.isRequired

  link: ->
    {network} = @props
    {user} = @context

    user["#{network}Link"]

  triggerLink: (event) ->
    {user} = @props

    event.preventDefault()

    if @link()? then @unlink() else @getLink()

  getLink: ->
    {network} = @props

    @["get#{_.capitalize network}Link"]()

  getFacebookLink: ->
    {user} = @context

    FB.login ({status}) ->
      return unless status == 'connected'
      FB.api '/me', fields: 'link', ({link}) ->
        UserActionCreators.update user.id, facebookLink: link

  getInstagramLink: ->
    {user} = @context

    clientId = process.env.TOP_INSTAGRAM_KEY
    redirectUri = "#{location.origin}/instagram"
    window.location = "https://instagram.com/oauth/authorize/?client_id=#{clientId}&redirect_uri=#{redirectUri}&response_type=token"

  unlink: ->
    {network} = @props
    {user} = @context

    UserActionCreators.update user.id, "#{network}Link": null

  button: ->
    {network} = @props
    {user} = @context

    return unless user.canEdit or @link()?

    onClick = if @link()? then _.noop else @triggerLink

    <a href={user["#{network}Link"]} className="user-profile_social-button m-#{network}" target="_blank" onClick={onClick}></a>

  linkInfo: ->
    {user} = @context

    return unless user.canEdit and @link()?

    <span className="user-profile_social-caption">
      Привязано
    </span>

  triggerLinkButton: ->
    {user} = @context

    return unless user.canEdit

    text = if @link()? then 'Отвязать' else 'Привязать'

    <div className="user-profile_social-link" onClick={@triggerLink}>
      {text}
    </div>

  render: ->
    {network} = @props
    {user} = @context

    classes = classNames 'user-profile_social',
      'm-add': user.canEdit and not @link()?
      'm-remove': user.canEdit and @link()?

    <div className={classes}>
      {@button()}
      {@linkInfo()}
      {@triggerLinkButton()}
    </div>

module.exports = SocialButton
