_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
ParsePage = require '../mixins/parse_page'
Loading = require '../mixins/loading'
ShowMore = require './show_more'
PaginationLink = require './pagination_link'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Marty.createAppMixin(), Loading]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    page: PropTypes.number.isRequired

  previewEnds:
    superLarge: 1
    large: 3
  subscriptionPosition: 1

  shouldShowLoader: ->
    {ratings} = @props

    _.isEmpty ratings

  ratings: ->
    {ratings} = @props
    {page} = @context

    ratingsFromPrevPages = @app.ratingsStore.getState().filter (rating) ->
      rating.page? and rating.page < page

    _(ratings).concat(ratingsFromPrevPages).sortBy('publishedAt').reverse().value()

  pagesCount: ->
    @app.pageCountsStore.get('ratings') || 0

  previews: ->
    @ratings().map (rating, index) =>
      type = _.findKey(@previewEnds, (end) -> _.inRange index, end) || 'normal'
      mod = _.kebabCase type
      imageSize = if type == 'normal' then 'preview' else 'large_preview'
      <Preview key={rating.id} rating={rating} mod={mod} imageSize={imageSize}/>

  showMore: ->
    {page} = @context

    return if page >= @pagesCount()

    <ShowMore/>

  render: ->
    {page} = @context

    <Layout>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      <Pagination currentPage={page} pagesCount={@pagesCount()} link={PaginationLink}/>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: 'ratingsStore'

  mixins: [ClearStores(false), ParsePage]

  childContextTypes:
    page: PropTypes.number.isRequired

  getChildContext: ->
    page: @page()

  fetch: ->
    @clearStoresOnce()
    ratings: @app.ratingsStore.getPage(@page())

  pending: (props) ->
    @done _.defaults({}, props, ratings: [])
