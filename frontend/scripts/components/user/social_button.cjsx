_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'

{PropTypes} = React

SocialButton = React.createClass
  displayName: 'SocialButton'

  mixins: [Marty.createAppMixin()]

  propTypes:
    network: PropTypes.string.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

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

    FB.login ({status}) =>
      return unless status == 'connected'
      FB.api '/me', fields: 'link', ({link}) =>
        @app.usersActions.update user.id, facebookLink: link

  getInstagramLink: ->
    {user} = @context

    clientId = process.env.TOP_INSTAGRAM_KEY
    redirectUri = "#{location.origin}/instagram"
    window.location = "https://instagram.com/oauth/authorize/?client_id=#{clientId}&redirect_uri=#{redirectUri}&response_type=token"

  unlink: ->
    {network} = @props
    {user} = @context

    @app.usersActions.update user.id, "#{network}Link": null

  button: ->
    {network} = @props
    {user, canEdit} = @context

    return unless canEdit or @link()?

    onClick = if @link()? then _.noop else @triggerLink

    <a href={user["#{network}Link"]} className="user-profile_social-button m-#{network}" target="_blank" onClick={onClick}></a>

  linkInfo: ->
    {canEdit} = @context

    return unless canEdit and @link()?

    <span className="user-profile_social-caption">
      Привязано
    </span>

  triggerLinkButton: ->
    {canEdit} = @context

    return unless canEdit

    text = if @link()? then 'Отвязать' else 'Привязать'

    <div className="user-profile_social-link" onClick={@triggerLink}>
      {text}
    </div>

  render: ->
    {network} = @props
    {canEdit} = @context

    classes = classNames 'user-profile_social',
      'm-add': canEdit and not @link()?
      'm-remove': canEdit and @link()?

    <div className={classes}>
      {@button()}
      {@linkInfo()}
      {@triggerLinkButton()}
    </div>

module.exports = SocialButton
