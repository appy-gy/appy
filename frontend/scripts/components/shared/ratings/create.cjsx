_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'

{PropTypes} = React

CreateRating = React.createClass
  displayName: 'CreateRating'

  mixins: [Marty.createAppMixin()]

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  create: ->
    {router} = @context

    @app.ratingsActions.create().then ({body}) =>
      router.transitionTo 'rating', ratingSlug: body.rating.slug

  render: ->
    {children} = @props

    props = _.omit @props, 'children'

    <div {...props} onClick={@create}>
      {children}
    </div>

module.exports = CreateRating
