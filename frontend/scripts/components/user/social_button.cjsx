_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
userActions = require '../../actions/user'

{PropTypes} = React
{connect} = ReactRedux
{updateUser} = userActions

SocialButton = React.createClass
  displayName: 'SocialButton'

  propTypes:
    dispatch: PropTypes.func.isRequired
    network: PropTypes.string.isRequired

  contextTypes:
    user: PropTypes.object.isRequired
    canEdit: PropTypes.bool.isRequired

  link: ->
    @context.user["#{@props.network}Link"]

  triggerLink: (event) ->
    {user} = @props

    event.preventDefault()

    if @link()? then @unlink() else @getLink()

  getLink: ->
    @["get#{_.capitalize @props.network}Link"]()

  getFacebookLink: ->
    FB.getLoginStatus ({status}) =>
      if status == 'connected'
        @fbGetLink()
      else
        FB.login @fbGetLink

  fbGetLink: ->
    {dispatch} = @props

    FB.api '/me', fields: 'link', ({link}) =>
      dispatch updateUser(facebookLink: link)

  getInstagramLink: ->
    {user} = @context

    clientId = process.env.TOP_INSTAGRAM_KEY
    redirectUri = "#{location.origin}/instagram"
    window.location = "https://instagram.com/oauth/authorize/?client_id=#{clientId}&redirect_uri=#{redirectUri}&response_type=token"

  unlink: ->
    @props.dispatch updateUser(@context.user.id, "#{@props.network}Link": null)

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
      <div className="user-profile_social-content">
        {@linkInfo()}
        {@triggerLinkButton()}
      </div>
    </div>

module.exports = connect()(SocialButton)
