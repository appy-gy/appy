_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
ParsePage = require '../mixins/parse_page'
Subscription = require './subscription'
PaginationLink = require './pagination_link'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
Pagination = require '../shared/pagination/pagination'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [Marty.createAppMixin()]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  contextTypes:
    router: PropTypes.func.isRequired
    page: PropTypes.number.isRequired

  previewEnds:
    superLarge: 1
    large: 3
  subscriptionPosition: 1

  subscription: ->
    <Subscription key="subscription"/>

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      mod = _.findKey @previewEnds, (end) -> _.inRange index, end
      <Preview key={rating.id} rating={rating} mod={_.kebabCase mod}/>

  content: ->
    {ratings} = @props

    _.tap @previews(), (previews) =>
      previews.splice @subscriptionPosition, 0, @subscription()

  render: ->
    {page} = @context

    pagesCount = @app.pageCountsStore.get('ratings') || 0

    <Layout>
      <div className="previews">
        {@content()}
      </div>
      <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: 'ratingsStore'

  mixins: [ClearStores, ParsePage]

  childContextTypes:
    page: PropTypes.number.isRequired

  getChildContext: ->
    page: @page()

  fetch: ->
    ratings: @app.ratingsStore.getPage(@page())

  pending: ->
    @done ratings: []
