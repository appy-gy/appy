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
{fetchSectionRatings, clearSectionRatings} = sectionRatingActions

Section = React.createClass
  displayName: 'Section'

  mixins: [Loading, ParsePage, RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    sectionSlug: PropTypes.string.isRequired
    section: PropTypes.object.isRequired
    isFetched: PropTypes.bool.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  componentWillMount: ->
    @fetchSection()

    @watch
      exp: => @props.sectionSlug
      onChange: =>
        @clearRatings()
        @fetchSection()
        @fetchRatings @page()

  isLoading: ->
    not @props.isFetched

  fetchSection: ->
    @props.dispatch fetchSection(@props.sectionSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchSectionRatings(page, @props.sectionSlug)

  clearRatings: ->
    @props.dispatch clearSectionRatings()

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
  ratings: sectionRatings.items
  section: section.item
  pagesCount: sectionRatings.pagesCount
  isFetched: _.any [sectionRatings, section], 'isFetched'

module.exports = connect(mapStateToProps)(Section)
