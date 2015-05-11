React = require 'react/addons'
VoteButton = require './vote_button'

{PropTypes} = React

Votes = React.createClass
  displayName: 'Votes'

  contextTypes:
    ratingItem: PropTypes.object.isRequired

  render: ->
    {ratingItem} = @context

    <div className="rating-item_actions">
      <VoteButton kind="down"/>
      <div className="rating-item_mark">{ratingItem.mark}</div>
      <VoteButton kind="up"/>
    </div>

module.exports = Votes
