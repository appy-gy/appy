React = require 'react'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
Login = require '../shared/auth/login'

{PropTypes} = React
{connect} = ReactRedux
{voteFromRatingItem} = ratingItemActions

VoteButton = React.createClass
  displayName: 'VoteButton'

  propTypes:
    dispatch: PropTypes.func.isRequired
    kind: PropTypes.string.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired
    ratingItem: PropTypes.object.isRequired

  vote: ->
    {dispatch, kind} = @props
    {currentUser, ratingItem} = @context

    return unless currentUser.id?

    dispatch voteFromRatingItem(ratingItem.id, kind)

  render: ->
    {kind} = @props
    {currentUser, ratingItem} = @context

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind
    Component = if currentUser.id? then 'div' else Login

    <Component onSuccess={@vote}>
      <div className={classes} onClick={@vote}></div>
    </Component>

module.exports = connect()(VoteButton)
