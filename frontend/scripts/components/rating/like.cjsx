React = require 'react/addons'
RatingActionCreators = require '../../action_creators/ratings'

{PropTypes} = React

Like = React.createClass
  displayName: 'Like'

  contextTypes:
    rating: PropTypes.object.isRequired

  create: ->
    {rating} = @context

    RatingActionCreators.like rating.id

  render: ->
    <div className="rating-like" onClick={@create}>
      <div className="rating-like-burst-1"></div>
      <div className="rating-like-burst-2"></div>
      <div className="rating-like-content"></div>
    </div>

module.exports = Like
