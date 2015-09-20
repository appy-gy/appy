_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
currentUserActions = require '../actions/current_user'
ClearState = require './mixins/clear_state'
Nothing = require './shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{DragDropContext} = ReactDnd
{fetchCurrentUser} = currentUserActions

App = React.createClass
  displayName: 'App'

  mixins: [ClearState]

  propTypes:
    dispatch: PropTypes.func.isRequired
    params: PropTypes.object.isRequired
    currentUser: PropTypes.object.isRequired
    isFetched: PropTypes.bool.isRequired
    children: PropTypes.node.isRequired

  childContextTypes:
    currentUser: PropTypes.object.isRequired

  componentWillMount: ->
    @fetchCurrentUser()

  getChildContext: ->
    _.pick @props, 'currentUser'

  fetchCurrentUser: ->
    @props.dispatch fetchCurrentUser()

  render: ->
    {isFetched, children} = @props

    return <Nothing/> unless isFetched

    children

mapStateToProps = ({router, currentUser}) ->
  params: router.params
  currentUser: currentUser.item,
  isFetched: currentUser.isFetched

module.exports = DragDropContext(HTML5Backend)(connect(mapStateToProps)(App))
