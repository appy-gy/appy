React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'

{PropTypes} = React

VoteButton = React.createClass
  displayName: 'VoteButton'

  mixins: [Marty.createAppMixin()]

  propTypes:
    kind: PropTypes.string.isRequired

  contextTypes:
    ratingItem: PropTypes.object.isRequired

  vote: ->
    {kind} = @props
    {ratingItem} = @context

    @app.votesActions.create ratingItem.id, kind

  render: ->
    {kind} = @props
    {ratingItem} = @context

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind

    <div className={classes} onClick={@vote}></div>

module.exports = VoteButton
