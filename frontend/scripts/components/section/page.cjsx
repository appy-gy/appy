_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
ReduxRouter = require 'redux-router'
Helmet = require 'react-helmet'
sectionActions = require '../../actions/section'
sectionRatingActions = require '../../actions/section_ratings'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{replaceState} = ReduxRouter
{fetchSection} = sectionActions
{fetchSectionRatings} = sectionRatingActions

Section = React.createClass
  displayName: 'Section'

  mixins: [RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    section: PropTypes.object.isRequired
    sectionSlug: PropTypes.string.isRequired
    isFetching: PropTypes.bool.isRequired
    isFailed: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchSection()

  componentDidUpdate: ->
    @fetchSection()

  fetchSection: ->
    @props.dispatch fetchSection(@props.sectionSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchSectionRatings(@props.sectionSlug, page)

  changePage: (page) ->
    @props.dispatch replaceState(null, "/#{@props.sectionSlug}", { page })

  helmet: ->
    {section} = @props

    meta = [
      { name: 'description', content: section.metaDescription }
      { name: 'keywords', content: section.metaKeywords }
    ]

    <Helmet title={section.metaTitle} meta={meta}/>

  previews: ->
    @ratings().map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    {section, sectionSlug, isFetching, isFailed} = @props

    <Layout isLoading={isFetching} isFound={not isFailed}>
      {@helmet()}
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
  isFetching: _.some [sectionRatings, section], 'isFetching'
  isFailed: _.some [sectionRatings, section], 'isFailed'

module.exports = connect(mapStateToProps)(Section)
