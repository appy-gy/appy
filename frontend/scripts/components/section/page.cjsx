_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
sectionActions = require '../../actions/section'
sectionRatingActions = require '../../actions/section_ratings'
Loading = require '../mixins/loading'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchSection} = sectionActions
{fetchSectionRatings} = sectionRatingActions

Section = React.createClass
  displayName: 'Section'

  mixins: [Loading, RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    section: PropTypes.object.isRequired
    sectionSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchSection()

  componentDidUpdate: ->
    @fetchSection()

  isLoading: ->
    not @props.isFetched

  fetchSection: ->
    @props.dispatch fetchSection(@props.sectionSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchSectionRatings(@props.sectionSlug, page)

  changePage: (page) ->
    @props.dispatch replaceState(null, "/sections/#{@props.sectionSlug}", { page })

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

mapStateToProps = ({router, sectionRatings, section}, {sectionSlug}) ->
  ratings: sectionRatings.items
  section: section.item
  sectionSlug: router.params.sectionSlug
  page: parseInt(router.location.query?.page || 1)
  pagesCount: sectionRatings.pagesCount
  isFetched: _.any [sectionRatings, section], 'isFetched'

module.exports = connect(mapStateToProps)(Section)
