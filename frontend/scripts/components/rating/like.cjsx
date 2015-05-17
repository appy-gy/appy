React = require 'react/addons'
classNames = require 'classnames'
RatingActionCreators = require '../../action_creators/ratings'

{PropTypes} = React

Like = React.createClass
  displayName: 'Like'

  contextTypes:
    rating: PropTypes.object.isRequired

  triggerLike: ->
    {rating} = @context

    action = if rating.like? then 'unlike' else 'like'
    RatingActionCreators[action] rating.id

  subbursts: ->
    {rating} = @context

    [1, 2].map (index) ->
      classes = classNames "rating_like-burst-#{index}", 'm-active': rating.like?
      <div key={index} className={classes}/>

  render: ->
    {rating} = @context

    <div className="rating_like" onClick={@triggerLike}>
      {@subbursts()}
      <div className="rating_like-content"></div>
    </div>

module.exports = Like
