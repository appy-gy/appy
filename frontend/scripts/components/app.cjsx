_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReactDnd = require 'react-dnd'
HTML5Backend = require 'react-dnd/modules/backends/HTML5'
Helmet = require 'react-helmet'
currentUserActions = require '../actions/current_user'
ClearState = require './mixins/clear_state'
LoginNotifier = require './mixins/login_notifier'
Nothing = require './shared/nothing'
startServiceWorker = require '../helpers/start_service_worker'

{PropTypes} = React
{connect} = ReactRedux
{DragDropContext} = ReactDnd
{fetchCurrentUser} = currentUserActions

App = React.createClass
  displayName: 'App'

  mixins: [ClearState, LoginNotifier]

  propTypes:
    dispatch: PropTypes.func.isRequired
    params: PropTypes.object.isRequired
    currentUser: PropTypes.object.isRequired
    isFetched: PropTypes.bool.isRequired
    children: PropTypes.node.isRequired

  childContextTypes:
    currentUser: PropTypes.object.isRequired

  title: "Appy.gy - %s"

  meta: [
    { name: 'description', content: 'Все самое интересное: технологии, интересные книги, интересное видео, советы о бизнесе и лайфстайле, интересные факты, игры' }
    { name: 'keywords', content: 'интересное видео, интересные факты, книги, кино, косплей, хобби, путешествия, мода, здоровье, еда, портал' }
  ]

  componentWillMount: ->
    @fetchCurrentUser().then (user) ->
      return unless user?
      startServiceWorker()

  getChildContext: ->
    _.pick @props, 'currentUser'

  fetchCurrentUser: ->
    @props.dispatch fetchCurrentUser()

  content: ->
    if @props.isFetched then @props.children else <Nothing/>

  render: ->
    <span>
      <Helmet titleTemplate={@title} meta={@meta}/>
      {@content()}
    </span>

mapStateToProps = ({router, currentUser}) ->
  params: router.params
  currentUser: currentUser.item,
  isFetched: currentUser.isFetched

module.exports = DragDropContext(HTML5Backend)(connect(mapStateToProps)(App))
