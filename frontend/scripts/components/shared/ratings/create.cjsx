_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
ratingActions = require '../../../actions/rating'
Login = require '../auth/login'

{PropTypes} = React
{connect} = ReactRedux
{pushState} = ReduxReactRouter
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

    return unless currentUser.id?

    dispatch(createRating()).then ({slug}) ->
      dispatch pushState(null, "/ratings/#{slug}")

  render: ->
    {children} = @props
    {currentUser} = @context

    props = _.omit @props, 'children'
    Component = if currentUser.id? then 'div' else Login

    <Component {...props} onSuccess={@create}>
      <div onClick={@create}>
        {children}
      </div>
    </Component>

module.exports = connect()(CreateRating)
