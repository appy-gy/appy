React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'

{PropTypes} = React

Like = React.createClass
  displayName: 'Like'

  mixins: [Marty.createAppMixin()]

  contextTypes:
    rating: PropTypes.object.isRequired

  childClasses: (klass) ->
    {rating} = @context

    classNames klass, 'm-active': rating.like?

  triggerLike: ->
    {rating} = @context

    action = if rating.like? then 'unlike' else 'like'
    @app.ratingsActions[action] rating.id

  subbursts: ->
    {rating} = @context

    [1, 2].map (index) =>
      <div key={index} className={@childClasses("rating_like-burst-#{index}")}/>

  render: ->
    <div className="rating_like-wrapper">
      <div className="rating_like" onClick={@triggerLike}>
        <div className={@childClasses('rating_like-icon')}></div>
        <div className={@childClasses('rating_like-content')}>12378</div>
      </div>
    </div>

module.exports = Like
