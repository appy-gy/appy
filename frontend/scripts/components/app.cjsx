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
    isFetched: PropTypes.bool.isRequired

  childContextTypes:
    currentUser: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchCurrentUser()

  getChildContext: ->
    _.pick @props, 'currentUser'

  fetchCurrentUser: ->
    @props.dispatch fetchCurrentUser()

  render: ->
    {isFetched} = @props

    return <Nothing/> unless isFetched

    props = _.omit @props, 'dispatch', 'currentUser', 'isFetched'

    <RouteHandler {...@props}/>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item, isFetched: currentUser.isFetched

module.exports = DragDropContext(HTML5Backend)(connect(mapStateToProps)(App))
