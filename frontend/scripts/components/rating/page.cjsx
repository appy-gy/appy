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
    currentUser: PropTypes.object.isRequired
    rating: PropTypes.object.isRequired
    ratingSlug: PropTypes.string.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    isFetched: PropTypes.bool.isRequired

  childContextTypes:
    block: PropTypes.string.isRequired

  componentWillMount: ->
    @fetchRating()
    @fetchRatingItems()

  componentDidUpdate: ->
    @fetchRating()
    @fetchRatingItems()

  getChildContext: ->
    block: 'rating'

  shouldComponentUpdate: ({ratingSlug}) ->
    # FIXME: ratingSlug becomes undefined when goBack called, because
    # page get changed after one more render of previous page
    ratingSlug?

  meta: ->
    {rating} = @props

    description = strip(_.unescape(rating.description?.split('\n')?[0] || ''))

    [
      { name: 'description', content: description }
      { name: 'keywords', content: _.map(rating.tags, 'name').join(', ') }
      { property: 'og:title', content: rating.title }
      { property: 'og:description', content: description }
      { property: 'og:image', content: rating.image }
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
    canEditRating @props.currentUser, rating

  header: ->
    if @canEdit() then 'editRating' else 'rating'

  similar: ->
    {rating} = @props

    <Similar rating={rating}/> if rating.status == 'published'

  comments: ->
    {rating} = @props

    <Comments rating={rating}/> if rating.status == 'published'

  render: ->
    {rating, ratingItems, isFetched} = @props

    <Layout header={@header()} isLoading={not isFetched}>
      <Helmet title={rating.title} meta={@meta()}/>
      <Rating rating={rating} ratingItems={ratingItems} canEdit={@canEdit()}/>
      {@similar()}
      {@comments()}
    </Layout>

mapStateToProps = ({currentUser, router, rating, ratingItems}) ->
  currentUser: currentUser.item
  rating: rating.item
  ratingItems: ratingItems.items
  ratingSlug: router.params.ratingSlug
  isFetched: _.any [rating, ratingItems], 'isFetched'

module.exports = connect(mapStateToProps)(RatingPage)
