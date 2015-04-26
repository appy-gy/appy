_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Qs = require 'qs'
UserActionCreators = require '../../action_creators/users'
CurrentUserStore = require '../../stores/current_user'

{PropTypes} = React
{PureRenderMixin} = React.addons

Instagram = React.createClass
  displayName: 'Instagram'

  mixins: [PureRenderMixin]

  contextTypes:
    router: React.PropTypes.func

  componentDidMount: ->
    {user} = @props
    {access_token, error} = Qs.parse _.trimLeft(location.hash, '#')

    redirect() if @error?

    window.instagramCallback = ({data}) =>
      link = "https://instagram.com/#{data.username}"
      UserActionCreators.update user.id, instagramLink: link
      @redirect()
      delete window.instagramCallback

    clientId = process.env.TOP_INSTAGRAM_KEY
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "https://api.instagram.com/v1/users/self/?cliend_id=#{clientId}&access_token=#{access_token}&callback=instagramCallback"
    script.async = true
    @getDOMNode().appendChild script

  redirect: ->
    {user} = @props
    {router} = @context

    router.transitionTo 'user', userId: user.id

  render: ->
    <div className="g-hidden"></div>

module.exports = Marty.createContainer Instagram,
  listenTo: CurrentUserStore

  fetch: ->
    user: CurrentUserStore.for(@).get()
