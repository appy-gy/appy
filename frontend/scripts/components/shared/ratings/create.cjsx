_ = require 'lodash'
React = require 'react/addons'
Login = require '../auth/login'

{PropTypes} = React

CreateRating = React.createClass
  displayName: 'CreateRating'

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired

  create: ->
    {router, currentUser} = @context

    return unless currentUser.id?

    @app.ratingsActions.create().then ({body}) =>
      router.transitionTo 'rating', ratingSlug: body.rating.slug

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

module.exports = CreateRating
