_ = require 'lodash'
React = require 'react/addons'
RatingActionCreators = require '../../../action_creators/ratings'

{PropTypes} = React

CreateRating = React.createClass
  displayName: 'CreateRating'

  propTypes:
    children: PropTypes.node.isRequired

  contextTypes:
    router: React.PropTypes.func

  create: ->
    {router} = @context

    RatingActionCreators.create().then ({body}) =>
      router.transitionTo 'rating', ratingId: body.rating.id
    
  render: ->
    {className, children} = @props

    props = _.omit @props, 'children'

    <div {...props} onClick={@create}>
      {children}
    </div>

module.exports = CreateRating
