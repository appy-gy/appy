_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxReactRouter = require 'redux-react-router'
ratingActions = require '../../actions/ratings'
Loading = require '../mixins/loading'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxReactRouter
{fetchRatings} = ratingActions

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Loading, RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    fetchingPages: PropTypes.arrayOf(PropTypes.number).isRequired

  previewEnds:
    superLarge: 1
    large: 3

  isLoading: ->
    not _.isEmpty @props.fetchingPages

  fetchRatings: (page) ->
    @props.dispatch fetchRatings(page)

  changePage: (page) ->
    @props.dispatch replaceState(null, '/', { page })

  showFirstPage: ->
    @loadPage 1

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

mapStateToProps = ({router, ratings}) ->
  ratings: ratings.items
  page: parseInt(router.location.query?.page || 1)
  fetchingPages: ratings.fetchingPages
  pagesCount: ratings.pagesCount

module.exports = connect(mapStateToProps)(Ratings)
