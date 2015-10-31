React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
VoteButton = require './vote_button'

{PropTypes} = React

Votes = React.createClass
  displayName: 'Votes'

  mixins: [PureRendexMixin]

  propTypes:
    ratingItem: PropTypes.object.isRequired

  render: ->
    {ratingItem} = @props

    <div className="rating-item_actions">
      <VoteButton ratingItem={ratingItem} kind="down"/>
      <div className="rating-item_mark">{ratingItem.mark}</div>
      <VoteButton ratingItem={ratingItem} kind="up"/>
    </div>

module.exports = Votes
