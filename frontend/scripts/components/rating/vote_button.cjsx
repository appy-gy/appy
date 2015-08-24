React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
Login = require '../shared/auth/login'

{PropTypes} = React

VoteButton = React.createClass
  displayName: 'VoteButton'

  mixins: [Marty.createAppMixin()]

  propTypes:
    kind: PropTypes.string.isRequired

  contextTypes:
    ratingItem: PropTypes.object.isRequired

  vote: ->
    {kind, currentUser} = @props
    {ratingItem} = @context

    return unless currentUser.isLoggedIn()

    @app.votesActions.create ratingItem.id, kind

  render: ->
    {kind, currentUser} = @props
    {ratingItem} = @context

    classes = classNames 'rating-item_button', "m-#{kind}", 'm-active': ratingItem.vote?.kind == kind
    Component = if currentUser.isLoggedIn() then 'div' else Login

    <Component onSuccess={@vote}>
      <div className={classes} onClick={@vote}></div>
    </Component>

module.exports = Marty.createContainer VoteButton,
  listenTo: 'currentUserStore'

  fetch: ->
    currentUser: @app.currentUserStore.get()
