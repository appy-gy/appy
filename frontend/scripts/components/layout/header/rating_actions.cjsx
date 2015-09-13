React = require 'react/addons'
Publish = require '../../shared/ratings/publish'
Delete = require '../../shared/ratings/delete'

{PropTypes} = React

RatingActions = React.createClass
  displayName: 'RatingActions'

  contextTypes:
    router: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  redirectToProfile: ->
    @context.router.replaceWith 'user', userSlug: @context.currentUser.slug

  render: ->
    {rating, ratingItems} = @context

    <div className="header_rating-actions">
      <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>
      <Delete ref="delete" rating={rating} onDelete={@redirectToProfile}/>
    </div>

module.exports = RatingActions
