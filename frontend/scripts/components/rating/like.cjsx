React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingActions = require '../../actions/rating'
Login = require '../shared/auth/login'

{PropTypes} = React
{connect} = ReactRedux
{likeRating, unlikeRating} = ratingActions

Like = React.createClass
  displayName: 'Like'

  mixins: [PureRenderMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired

  childClasses: (klass) ->
    {rating} = @props

    classNames klass, 'm-active': rating.like?

  triggerLike: ->
    {dispatch, currentUser, rating} = @props

    return unless currentUser.id?

    action = if rating.like? then unlikeRating else likeRating
    dispatch action()

  subbursts: ->
    {rating} = @props

    [1, 2].map (index) =>
      <div key={index} className={@childClasses("rating_like-burst-#{index}")}/>

  render: ->
    {currentUser, rating} = @props

    Component = if currentUser.id? then 'div' else Login

    <Component className="rating_like-wrapper" onSuccess={@triggerLike}>
      <div ref="like" className="rating_like" onClick={@triggerLike}>
        <div className={@childClasses('rating_like-icon')}></div>
        <div ref="counter" className={@childClasses('rating_like-content')}>{rating.likesCount}</div>
      </div>
    </Component>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(Like)
