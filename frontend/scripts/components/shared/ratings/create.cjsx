_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Login = require '../auth/login'

{PropTypes} = React

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [Marty.createAppMixin()]

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  create: ->
    {currentUser} = @props
    {router} = @context

    return unless currentUser.id?

    @app.ratingsActions.create().then ({body}) =>
      router.transitionTo 'rating', ratingSlug: body.rating.slug

  render: ->
    {currentUser, children} = @props

    props = _.omit @props, 'children'
    Component = if currentUser.id? then 'div' else Login

    <Component {...props} onSuccess={@create}>
      <div onClick={@create}>
        {children}
      </div>
    </Component>

module.exports = Marty.createContainer CreateRating,
  listenTo: 'currentUserStore'

  fetch: ->
    currentUser: @app.currentUserStore.get()
