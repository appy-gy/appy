React = require 'react/addons'
Marty = require 'marty'
Publish = require '../../shared/ratings/publish'
Delete = require '../../shared/ratings/delete'

{PropTypes} = React

RatingActions = React.createClass
  displayName: 'RatingActions'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    router: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  redirectToProfile: ->
    {router} = @context
    {slug} = @app.currentUserStore.getState()

    router.replaceWith 'user', userSlug: slug

  render: ->
    {rating, ratingItems} = @context

    <div className="header_rating-actions">
      <Publish rating={rating} ratingItems={ratingItems}/>
      <Delete rating={rating} onDelete={@redirectToProfile}/>
    </div>

module.exports = RatingActions
