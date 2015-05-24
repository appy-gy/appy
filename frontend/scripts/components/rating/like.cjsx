React = require 'react/addons'
classNames = require 'classnames'
RatingActionCreators = require '../../action_creators/ratings'

{PropTypes} = React

Like = React.createClass
  displayName: 'Like'

  contextTypes:
    rating: PropTypes.object.isRequired

  childClasses: (klass) ->
    {rating} = @context

    classNames klass, 'm-active': rating.like?

  triggerLike: ->
    {rating} = @context

    action = if rating.like? then 'unlike' else 'like'
    RatingActionCreators[action] rating.id

  subbursts: ->
    {rating} = @context

    [1, 2].map (index) =>
      <div key={index} className={@childClasses("rating_like-burst-#{index}")}/>

  render: ->
    <div className="rating_like" onClick={@triggerLike}>
      {@subbursts()}
      <div className={@childClasses('rating_like-content')}></div>
    </div>

module.exports = Like
