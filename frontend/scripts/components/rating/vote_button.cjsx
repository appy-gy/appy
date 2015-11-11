React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
OnLogin = require '../mixins/on_login'
Login = require '../shared/auth/login'

{PropTypes} = React
{connect} = ReactRedux
{voteForRatingItem} = ratingItemActions

VoteButton = React.createClass
  displayName: 'VoteButton'

  mixins: [PureRenderMixin, OnLogin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    ratingItem: PropTypes.object.isRequired
    kind: PropTypes.string.isRequired

  onLoginKey: 'voteButton'

  vote: ->
    {currentUser, ratingItem, kind} = @props

    if currentUser.id? then @dispatchVote(ratingItem.id, kind) else @onLogin('dispatchVote', ratingItem.id, kind)

  dispatchVote: (ratingItemId, kind) ->
    @props.dispatch voteForRatingItem(ratingItemId, kind)

  render: ->
    {currentUser, ratingItem, kind} = @props

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind
    Component = if currentUser.id? then 'div' else Login

    <Component>
      <div className={classes} onClick={@vote}></div>
    </Component>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(VoteButton)
