_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Loading = require '../mixins/loading'
ParsePage = require '../mixins/parse_page'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{CSSTransitionGroup} = React.addons

SectionRatings = React.createClass
  displayName: 'SectionRatings'

  mixins: [Loading, RatingsList]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    section: PropTypes.object.isRequired

  shouldShowLoader: ->
    {ratings} = @props

    _.isEmpty ratings

  pagesCountKey: ->
    {sectionSlug} = @props

    "sectionRatings-#{sectionSlug}"

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    <Layout>
      <CSSTransitionGroup className="previews" transitionName="m" transitionAppear={true}>
        {@previews()}
      </CSSTransitionGroup>
      {@showMore()}
      {@pagination()}
    </Layout>

module.exports = Marty.createContainer SectionRatings,
  listenTo: ['ratingsStore', 'sectionsStore']

  mixins: [ClearStores(false), ParsePage]

  childContextTypes:
    page: PropTypes.number.isRequired
    loadPage: PropTypes.func.isRequired

  getChildContext: ->
    { page: @page(), @loadPage }

  loadPage: (page) ->
    {sectionSlug} = @props

    @app.ratingsStore.getForSection(sectionSlug, page)

  fetch: ->
    {sectionSlug} = @props

    @clearStoresOnce()

    section: @app.sectionsStore.get(sectionSlug)
    ratings: @loadPage(@page())
