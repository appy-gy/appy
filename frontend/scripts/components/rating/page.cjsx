_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Helmet = require 'react-helmet'
strip = require 'strip'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
isClient = require '../../helpers/is_client'
canEditRating = require '../../helpers/ratings/can_edit'
SyncSlug = require '../mixins/sync_slug'
Rating = require './rating'
Similar = require './similar'
Comments = require './comments'
Layout = require '../layout/layout'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter
{fetchRating} = ratingActions
{fetchRatingItems} = ratingItemActions

syncSlugMixin = SyncSlug 'rating', (slug, {rating}) ->
  "/#{rating.section.slug}/#{slug}"

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [syncSlugMixin]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingSlug: PropTypes.string.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    isFetched: PropTypes.bool.isRequired

  contextTypes:
    currentUser: PropTypes.object.isRequired

  childContextTypes:
    rating: PropTypes.object.isRequired
    ratingSlug: PropTypes.string.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    block: PropTypes.string.isRequired
    canEdit: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchRating()
    @fetchRatingItems()

  componentDidUpdate: ->
    @fetchRating()
    @fetchRatingItems()

  getChildContext: ->
    {rating, ratingSlug, ratingItems} = @props
    {currentUser} = @context

    { rating, ratingSlug, ratingItems, block: 'rating', canEdit: @canEdit() }

  meta: ->
    {rating} = @props

    [
      { name: 'description', content: strip(_.unescape(rating.description?.split('\n')?[0] || '')) }
      { name: 'keywords', content: _.map(rating.tags, 'name').join(', ') }
    ]

  checkAccess: (rating) ->
    {dispatch} = @props

    return if rating.status == 'published' or @canEdit(rating)
    dispatch replaceState(null, '/') if isClient()

  fetchRating: ->
    @props.dispatch(fetchRating(@props.ratingSlug)).then (rating) =>
      @checkAccess rating if rating.id?

  fetchRatingItems: ->
    @props.dispatch fetchRatingItems(@props.ratingSlug)

  canEdit: (rating = @props.rating) ->
    canEditRating @context.currentUser, rating

  header: ->
    if @canEdit() then 'editRating' else 'rating'

  similar: ->
    <Similar/> if @props.rating.status == 'published'

  comments: ->
    <Comments/> if @props.rating.status == 'published'

  render: ->
    {rating, ratingSlug, isFetched} = @props

    <Layout header={@header()} isLoading={not isFetched}>
      <Helmet title={rating.title} meta={@meta()}/>
      <Rating/>
      {@similar()}
      {@comments()}
    </Layout>

mapStateToProps = ({router, rating, ratingItems}) ->
  rating: rating.item
  ratingItems: ratingItems.items
  ratingSlug: router.params.ratingSlug
  isFetched: _.any [rating, ratingItems], 'isFetched'

module.exports = connect(mapStateToProps)(RatingPage)
