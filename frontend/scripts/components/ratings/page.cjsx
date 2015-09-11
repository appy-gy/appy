_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
ratingActions = require '../../actions/ratings'
ClearStores = require '../mixins/clear_stores'
Loading = require '../mixins/loading'
ParsePage = require '../mixins/parse_page'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchRatings} = ratingActions

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Loading, ParsePage, RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    pagesCount: PropTypes.number.isRequired
    isFetching: PropTypes.bool.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  previewEnds:
    superLarge: 1
    large: 3

  shouldShowLoader: ->
    @props.isFetching

  fetchRatings: (page) ->
    @props.dispatch fetchRatings(page)

  pagesCount: ->
    @props.pagesCount

  changePage: (page) ->
    {router} = @context

    params = _.defaults { page }, router.getCurrentParams()
    router.replaceWith 'ratings', params, router.getCurrentQuery()

  showFirstPage: ->
    @loadPage 1

  ratings: ->
    {ratings} = @props
    {visiblePages} = @state

    _ ratings
      .filter (rating) -> _.includes visiblePages, rating.page
      .sortBy (rating) -> -Date.parse(rating.publishedAt)
      .value()

  previews: ->
    @ratings().map (rating, index) =>
      type = _.findKey @previewEnds, (end) -> _.inRange index, end if rating.page == 1
      type ||= 'normal'
      mod = _.kebabCase type
      imageSize = if type == 'normal' then 'preview' else 'large_preview'
      <Preview key={rating.id} rating={rating} mod={mod} imageSize={imageSize}/>

  render: ->
    <Layout onLogoClick={@showFirstPage}>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

mapStateToProps = ({ratings}) ->
  _.merge ratings: ratings.items, _.pick(ratings, 'pagesCount', 'isFetching')

module.exports = connect(mapStateToProps)(Ratings)
