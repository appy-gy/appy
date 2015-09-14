_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
Router = require 'react-router'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
currentUserActions = require '../actions/current_user'
Nothing = require './shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{RouteHandler} = Router
{DragDropContext} = ReactDnd
{fetchCurrentUser} = currentUserActions

App = React.createClass
  displayName: 'App'

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    isFetching: PropTypes.bool.isRequired

  childContextTypes:
    currentUser: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchCurrentUser()

  getChildContext: ->
    _.pick @props, 'currentUser'

  fetchCurrentUser: ->
    @startFetching = true
    @props.dispatch fetchCurrentUser()

  render: ->
    {isFetching} = @props

    return <Nothing/> if not @startFetching or isFetching

    <RouteHandler {...@props}/>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item, isFetching: currentUser.isFetching

module.exports = DragDropContext(HTML5Backend)(connect(mapStateToProps)(App))
