_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'
findInStore = require '../../helpers/find_in_store'
canEditRating = require '../../helpers/ratings/can_edit'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [Marty.createAppMixin(), ClearStores(), SyncSlug('rating'), Loading]

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  getChildContext: ->
    {ratingSlug, user} = @props

    { ratingSlug, block: 'rating', canEdit: canEditRating(user, @rating()) }

  shouldShowLoader: ->
    not @rating()?

  rating: (ratingSlug = @props.ratingSlug) ->
    findInStore @app.ratingsStore, ratingSlug

  header: ->
    {user} = @props
    
    if canEditRating(user, @rating()) then 'editRating' else 'rating'

  sectionSlug: ->
    {ratingSlug} = @props

    _.get @rating(), 'section.slug', 'default'

  render: ->
    {ratingSlug} = @props

    <Layout header={@header()} sectionSlug={@sectionSlug()}>
      <Rating/>
      <Comments/>
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore', 'currentUserStore']

  fetch: ->
    user: @app.currentUserStore.get()
