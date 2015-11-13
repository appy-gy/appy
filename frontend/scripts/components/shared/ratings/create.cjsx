_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
ratingActions = require '../../../actions/rating'
OnLogin = require '../../mixins/on_login'
Login = require '../auth/login'

{PropTypes} = React
{connect} = ReactRedux
{pushState} = ReduxRouter
{createRating} = ratingActions

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [OnLogin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired

  onLoginKey: 'createRating'

  create: ->
    {currentUser} = @context

    yaCounter32717200?.reachGoal('clickCreateRatingButton')

    if currentUser.id? then @dispatchCreate() else @onLogin('dispatchCreate')

  dispatchCreate: ->
    {dispatch} = @props

    dispatch(createRating()).then ({slug}) ->
      dispatch pushState(null, "/ratings/#{slug}/edit")

  render: ->
    {children} = @props
    {currentUser} = @context

    props = _.omit @props, 'children'
    Component = if currentUser.id? then 'div' else Login

    <Component {...props}>
      <div onClick={@create}>
        {children}
      </div>
    </Component>

module.exports = connect()(CreateRating)
