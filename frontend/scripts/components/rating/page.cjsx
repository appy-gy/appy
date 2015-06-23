_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
SyncSlug = require '../mixins/sync_slug'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'
findInStore = require '../../helpers/find_in_store'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [Marty.createAppMixin(), ClearStores, SyncSlug('rating')]

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getChildContext: ->
    {ratingSlug} = @props

    { ratingSlug, block: 'rating', canEdit: @canEdit() }

  canEdit: ->
    {user} = @props
    rating = @rating()

    user.isLoggedIn() and rating?.user.id == user.id

  rating: (ratingSlug = @props.ratingSlug) ->
    findInStore @app.ratingsStore, ratingSlug

  sectionSlug: ->
    {ratingSlug} = @props

    _.get @rating(), 'section.slug', 'default'

  render: ->
    {ratingSlug} = @props

    <Layout header="rating" sectionSlug={@sectionSlug()}>
      <Rating/>
      <Comments/>
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore', 'currentUserStore']

  fetch: ->
    user: @app.currentUserStore.get()
