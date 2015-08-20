_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
ParsePage = require '../mixins/parse_page'
Loading = require '../mixins/loading'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Marty.createAppMixin(), Loading, RatingsList]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  previewEnds:
    superLarge: 1
    large: 3
  subscriptionPosition: 1

  shouldShowLoader: ->
    {ratings} = @props

    _.isEmpty ratings

  pagesCountKey: ->
    'ratings'

  ratings: ->
    {visiblePages} = @state
    {page} = @context

    _ @app.ratingsStore.getState()
      .filter (rating) -> visiblePages.has rating.page
      .sortBy 'publishedAt'
      .reverse()
      .value()

  previews: ->
    @ratings().map (rating, index) =>
      type = _.findKey(@previewEnds, (end) -> _.inRange index, end) || 'normal'
      mod = _.kebabCase type
      imageSize = if type == 'normal' then 'preview' else 'large_preview'
      <Preview key={rating.id} rating={rating} mod={mod} imageSize={imageSize}/>

  render: ->
    <Layout>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: 'ratingsStore'

  mixins: [ClearStores(false), ParsePage]

  childContextTypes:
    page: PropTypes.number.isRequired
    loadPage: PropTypes.func.isRequired

  getChildContext: ->
    { page: @page(), @loadPage }

  loadPage: (page) ->
    @app.ratingsStore.getPage(page)

  fetch: ->
    @clearStoresOnce()
    ratings: @loadPage(@page())

  pending: (props) ->
    @done _.defaults({}, props, ratings: [])
