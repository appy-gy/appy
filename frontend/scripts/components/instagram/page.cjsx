_ = require 'lodash'
React = require 'react'
ReactDOM = require 'react-dom'
ReactRedux = require 'react-redux'
ReduxReachRouter = require 'redux-router'
Qs = require 'qs'
currentUserActions = require '../../actions/current_user'
Layout = require '../layout/layout'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxReachRouter
{updateCurrentUser} = currentUserActions

Instagram = React.createClass
  displayName: 'Instagram'

  propTypes:
    dispatch: PropTypes.func.isRequired

  contextTypes:
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
    ReactDOM.findDOMNode(@).appendChild(script)

  isLoading: ->
    true

  redirect: ->
    @props.dispatch replaceState(null, "/users/#{@context.currentUser.slug}")

  render: ->
    <Layout>
    </Layout>

module.exports = connect()(Instagram)
