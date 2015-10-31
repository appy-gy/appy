React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
ReactRedux = require 'react-redux'
classNames = require 'classnames'
ratingItemActions = require '../../actions/rating_items'
Login = require '../shared/auth/login'

{PropTypes} = React
{connect} = ReactRedux
{voteFromRatingItem} = ratingItemActions

VoteButton = React.createClass
  displayName: 'VoteButton'

  mixins: [PureRendexMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    currentUser: PropTypes.object.isRequired
    ratingItem: PropTypes.object.isRequired
    kind: PropTypes.string.isRequired

  vote: ->
    {dispatch, currentUser, ratingItem, kind} = @props

    return unless currentUser.id?

    dispatch voteFromRatingItem(ratingItem.id, kind)

  render: ->
    {currentUser, ratingItem, kind} = @props

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind
    Component = if currentUser.id? then 'div' else Login

    <Component onSuccess={@vote}>
      <div className={classes} onClick={@vote}></div>
    </Component>

mapStateToProps = ({currentUser}) ->
  currentUser: currentUser.item

module.exports = connect(mapStateToProps)(VoteButton)
