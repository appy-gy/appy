_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ratingActions = require '../../../actions/rating'
Login = require '../auth/login'

{PropTypes} = React
{connect} = ReactRedux
{createRating} = ratingActions

CreateRating = React.createClass
  displayName: 'CreateRating'

  propTypes:
    dispatch: PropTypes.func.isRequired
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired

  create: ->
    {dispatch} = @props
    {router, currentUser} = @context

    return unless currentUser.id?

    dispatch(createRating()).then ({slug}) ->
      router.transitionTo 'rating', ratingSlug: slug

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
