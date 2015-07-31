React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Login = require '../shared/auth/login'

{PropTypes} = React

Like = React.createClass
  displayName: 'Like'

  mixins: [Marty.createAppMixin()]

  propTypes:
    currentUser: PropTypes.object.isRequired

  contextTypes:
    rating: PropTypes.object.isRequired

  childClasses: (klass) ->
    {rating} = @context

    classNames klass, 'm-active': rating.like?

  triggerLike: ->
    {currentUser} = @props
    {rating} = @context

    return unless currentUser.isLoggedIn()

    action = if rating.like? then 'unlike' else 'like'
    @app.ratingsActions[action] rating.id

  subbursts: ->
    {rating} = @context

    [1, 2].map (index) =>
      <div key={index} className={@childClasses("rating_like-burst-#{index}")}/>

  render: ->
    {currentUser} = @props
    {rating} = @context

    Component = if currentUser.isLoggedIn() then 'div' else Login

    <Component className="rating_like-wrapper" onSuccess={@triggerLike}>
      <div ref="like" className="rating_like" onClick={@triggerLike}>
        <div className={@childClasses('rating_like-icon')}></div>
        <div ref="counter" className={@childClasses('rating_like-content')}>{rating.likesCount}</div>
      </div>
    </Component>

module.exports = Marty.createContainer Like,
  listenTo: 'currentUserStore'

  fetch: ->
    currentUser: @app.currentUserStore.get()
