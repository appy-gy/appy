_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
Qs = require 'qs'
currentUserActions = require '../../actions/current_user'
Loading = require '../mixins/loading'
Layout = require '../layout/layout'
Nothing = require '../shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{updateCurrentUser} = currentUserActions

Instagram = React.createClass
  displayName: 'Instagram'

  mixins: [Loading]

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired

  componentDidMount: ->
    {dispatch} = @props
    {access_token, error} = Qs.parse _.trimLeft(location.hash, '#')

    redirect() if @error?

    window.instagramCallback = ({data}) =>
      link = "https://instagram.com/#{data.username}"
      dispatch updateCurrentUser(instagramLink: link)
      @redirect()
      delete window.instagramCallback

    clientId = process.env.TOP_INSTAGRAM_KEY
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = "https://api.instagram.com/v1/users/self/?cliend_id=#{clientId}&access_token=#{access_token}&callback=instagramCallback"
    script.async = true
    @getDOMNode().appendChild script

  isLoading: ->
    true

  redirect: ->
    {currentUser, router} = @context

    router.transitionTo 'user', userSlug: currentUser.slug

  render: ->
    <Layout>
      <Nothing/>
    </Layout>

module.exports = connect()(Instagram)
