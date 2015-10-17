_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Helmet = require 'react-helmet'
ratingActions = require '../../actions/ratings'
mainPageRatingActions = require '../../actions/main_page_ratings'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
GlobalSearch = require '../shared/search/global'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter
{fetchRatings} = ratingActions
{fetchMainPageRatings} = mainPageRatingActions

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    mainPageRatings: PropTypes.object.isRequired
    isFetched: PropTypes.bool.isRequired

  previewEnds:
    superLarge: 1
    large: 3

  fetchRatings: (page) ->
    @props.dispatch fetchMainPageRatings() if page == 1
    @props.dispatch fetchRatings(page)

  changePage: (page) ->
    @props.dispatch replaceState(null, '/', { page })

  showFirstPage: ->
    @loadPage 1

  showMainPageRatings: ->
    _.includes @state.visiblePages, 1

  previews: ->
    {mainPageRatings} = @props
    {visiblePages} = @state

    ratings = @ratings()
    ratings = _(mainPageRatings).at('top', 'left', 'right').compact().concat(ratings).value() if @showMainPageRatings()
    ratings.map (rating, index) =>
      if @showMainPageRatings()
        type = _.findKey @previewEnds, (end) -> _.inRange index, end
      type ||= 'normal'
      mod = _.kebabCase type
      imageSize = if type == 'normal' then 'preview' else 'normal'
      <Preview key={rating.id} rating={rating} mod={mod} imageSize={imageSize}/>

  render: ->
    {isFetched} = @props

    <Layout isLoading={not isFetched} onLogoClick={@showFirstPage}>
      <Helmet title="информационно-развлекательный портал для творческих людей"/>
      <GlobalSearch/>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

mapStateToProps = ({router, ratings, mainPageRatings}) ->
  ratings: ratings.items
  mainPageRatings: mainPageRatings.item
  isFetched: not _.isEmpty(ratings.fetchingPages) || mainPageRatings.isFetched
  page: parseInt(router.location.query?.page || 1)
  pagesCount: ratings.pagesCount

module.exports = connect(mapStateToProps)(Ratings)
