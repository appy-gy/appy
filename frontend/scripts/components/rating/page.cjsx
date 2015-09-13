_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/rating'
ratingItemActions = require '../../actions/rating_items'
canEditRating = require '../../helpers/ratings/can_edit'
SyncSlug = require '../mixins/sync_slug'
Loading = require '../mixins/loading'
Watch = require '../mixins/watch'
Rating = require './rating'
Similar = require './similar'
Comments = require './comments'
Layout = require '../layout/layout'
Nothing = require '../shared/nothing'

{PropTypes} = React
{connect} = ReactRedux
{fetchRating} = ratingActions
{fetchRatingItems} = ratingItemActions

Rating = React.createClass
  displayName: 'Rating'

  mixins: [SyncSlug('rating'), Loading, Watch]

  propTypes:
    dispatch: PropTypes.func.isRequired
    rating: PropTypes.object.isRequired
    ratingSlug: PropTypes.string.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired
    isFetching: PropTypes.bool.isRequired

  contextTypes:
    router: PropTypes.func.isRequired
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

    @watch
      exp: ({ratingSlug}) -> ratingSlug
      onChange: =>
        @fetchRating()
        @fetchRatingItems()

  getChildContext: ->
    {rating, ratingSlug, ratingItems} = @props
    {currentUser} = @context

    { rating, ratingSlug, ratingItems, block: 'rating', canEdit: @canEdit() }

  isLoading: ->
    @props.isFetching or not @props.rating.id?

  fetchRating: ->
    @props.dispatch fetchRating(@props.ratingSlug)

  fetchRatingItems: ->
    @props.dispatch fetchRatingItems(@props.ratingSlug)

  canEdit: ->
    canEditRating @context.currentUser, @props.rating

  header: ->
    if @canEdit() then 'editRating' else 'rating'

  similar: ->
    <Similar/> if @props.rating.status == 'published'

  comments: ->
    <Comments/> if @props.rating.status == 'published'

  render: ->
    {ratingSlug} = @props

    return <Nothing/> if @isLoading()

    <Layout header={@header()}>
      {@similar()}
    </Layout>
      # <Rating ratingSlug={ratingSlug}/>
      # {@comments()}

mapStateToProps = ({rating, ratingItems}) ->
  rating: rating.item
  ratingItems: ratingItems.items
  isFetching: _.any [rating, ratingItems], 'isFetching'

module.exports = connect(mapStateToProps)(Rating)
