React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingActions = require '../../actions/rating'
OnLogin = require '../mixins/on_login'
Login = require '../shared/auth/login'

{PropTypes} = React
{connect} = ReactRedux

Like = React.createClass
  displayName: 'Like'

  mixins: [PureRenderMixin, OnLogin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired

  onLoginKey: 'like'

  childClasses: (klass) ->
    {rating} = @props

    classNames klass, 'm-active': rating.like?

  triggerLike: ->
    {dispatch, currentUser, rating} = @props

    actionName = if rating.like? then 'unlikeRating' else 'likeRating'
    if currentUser.id? then @dispatchLike(actionName, rating.id) else @onLogin('dispatchLike', actionName, rating.id)

  dispatchLike: (actionName, ratingId) ->
    @props.dispatch ratingActions[actionName](ratingId)

  subbursts: ->
    {rating} = @props

    [1, 2].map (index) =>
      <div key={index} className={@childClasses("rating_like-burst-#{index}")}/>

  render: ->
    {currentUser, rating} = @props

    Component = if currentUser.id? then 'div' else Login

    <Component className="rating_like-wrapper">
      <div ref="like" className="rating_like" onClick={@triggerLike}>
        <div className={@childClasses('rating_like-icon')}></div>
        <div ref="counter" className={@childClasses('rating_like-content')}>{rating.likesCount}</div>
      </div>
    </Component>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(Like)
