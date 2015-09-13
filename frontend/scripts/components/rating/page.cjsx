_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Rating = require './rating'
Similar = require './similar'
Comments = require './comments'
Layout = require '../layout/layout'
findInStore = require '../../helpers/find_in_store'
canEditRating = require '../../helpers/ratings/can_edit'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [Marty.createAppMixin(), SyncSlug('rating'), Loading]

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getChildContext: ->
    {ratingSlug, user} = @props

    { ratingSlug, block: 'rating', canEdit: canEditRating(user, @rating()) }

  isLoading: ->
    not @rating()?

  rating: (ratingSlug = @props.ratingSlug) ->
    findInStore @app.ratingsStore, ratingSlug

  header: ->
    {user} = @props

    if canEditRating(user, @rating()) then 'editRating' else 'rating'

  similar: ->
    <Similar/> if @rating()?.status == 'published'

  comments: ->
    <Comments/> if @rating()?.status == 'published'

  render: ->
    {ratingSlug} = @props

    <Layout header={@header()}>
      <Rating ratingSlug={ratingSlug}/>
      {@similar()}
      {@comments()}
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore', 'currentUserStore']

  fetch: ->
    user: @app.currentUserStore.get()
