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
    isFetched: PropTypes.bool.isRequired

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
    {section, sectionSlug, isFetched} = @props

    <Layout isLoading={not isFetched}>
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
  isFetched: _.any [sectionRatings, section], 'isFetched'

module.exports = connect(mapStateToProps)(Section)
