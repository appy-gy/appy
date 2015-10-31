_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
ratingActions = require '../../../actions/rating'
Login = require '../auth/login'

{PropTypes} = React
{connect} = ReactRedux
{pushState} = ReduxRouter
{createRating} = ratingActions

CreateRating = React.createClass
  displayName: 'CreateRating'

  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired

  create: ->
    {dispatch} = @props
    {currentUser} = @context

    yaCounter32717200?.reachGoal('clickCreateRatingButton')

    return unless currentUser.id?

    dispatch(createRating()).then ({slug}) ->
      dispatch pushState(null, "/ratings/#{slug}/edit")

  render: ->
    {children} = @props
    {currentUser} = @context

    props = _.omit @props, 'children'
    Component = if currentUser.id? then 'div' else Login

    <Component {...props} onSuccess={@create}>
      <span onClick={@create}>
        {children}
      </span>
    </Component>

module.exports = connect()(CreateRating)
