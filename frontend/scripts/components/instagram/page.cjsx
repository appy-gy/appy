_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Qs = require 'qs'
Layout = require '../layout/layout'

{PropTypes} = React
{PureRenderMixin} = React.addons

Instagram = React.createClass
  displayName: 'Instagram'

  mixins: [PureRenderMixin, Marty.createAppMixin()]

  contextTypes:
    router: PropTypes.func.isRequired

  componentDidMount: ->
    {user} = @props
    {access_token, error} = Qs.parse _.trimLeft(location.hash, '#')

    redirect() if @error?

    window.instagramCallback = ({data}) =>
      link = "https://instagram.com/#{data.username}"
      @app.usersActions.update user.id, instagramLink: link
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

    router.transitionTo 'user', userSlug: user.slug

  render: ->
    <Layout>
      <div className="g-hidden"></div>
    </Layout>

module.exports = Marty.createContainer Instagram,
  listenTo: 'currentUserStore'

  fetch: ->
    user: @app.currentUserStore.get()
