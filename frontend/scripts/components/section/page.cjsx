_ = require 'lodash'
React = require 'react/addons'
ReactRedux = require 'react-redux'
sectionActions = require '../../actions/section'
sectionRatingActions = require '../../actions/section_ratings'
Loading = require '../mixins/loading'
ParsePage = require '../mixins/parse_page'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchSection} = sectionActions
{fetchSectionRatings} = sectionRatingActions

Section = React.createClass
  displayName: 'Section'

  mixins: [Loading, ParsePage, RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    sectionSlug: PropTypes.string.isRequired
    section: PropTypes.object.isRequired
    isFetching: PropTypes.bool.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  componentWillMount: ->
    @fetchSection()

    @watch
      exp: ({sectionSlug}) -> sectionSlug
      onChange: =>
        @fetchSection()
        @fetchRatings @page()

  isLoading: ->
    @props.isFetching

  fetchSection: ->
    {dispatch, sectionSlug} = @props

    dispatch fetchSection(sectionSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchSectionRatings(@props.sectionSlug, page)

  changePage: (page) ->
    {router} = @context

    query = _.defaults { page }, router.getCurrentQuery()
    router.replaceWith 'section', router.getCurrentParams(), query

  previews: ->
    @ratings().map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    <Layout>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

mapStateToProps = ({sectionRatings, section}, {sectionSlug}) ->
  ratings: sectionRatings.items.filter (rating) -> rating.section.slug == sectionSlug
  section: section.item
  pagesCount: sectionRatings.pagesCount
  isFetching: _.any [sectionRatings, section], 'isFetching'

module.exports = connect(mapStateToProps)(Section)
