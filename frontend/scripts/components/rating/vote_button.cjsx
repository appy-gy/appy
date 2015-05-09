React = require 'react/addons'
classNames = require 'classnames'
VoteActionCreators = require '../../action_creators/votes'

{PropTypes} = React

VoteButton = React.createClass
  displayName: 'VoteButton'

  propTypes:
    kind: PropTypes.string.isRequired

  contextTypes:
    ratingItem: PropTypes.object.isRequired

  vote: ->
    {kind} = @props
    {ratingItem} = @context

    VoteActionCreators.create ratingItem.id, kind

  render: ->
    {kind} = @props
    {ratingItem} = @context

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind

    <div className={classes} onClick={@vote}></div>

module.exports = VoteButton
