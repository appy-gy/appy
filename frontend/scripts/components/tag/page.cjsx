_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Helmet = require 'react-helmet'
tagActions = require '../../actions/tag'
tagRatingActions = require '../../actions/tag_ratings'
RatingsList = require '../mixins/ratings_list'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'

{PropTypes} = React
{connect} = ReactRedux
{fetchTag} = tagActions
{fetchTagRatings} = tagRatingActions

Tag = React.createClass
  displayName: 'Tag'

  mixins: [RatingsList]

  propTypes:
    dispatch: PropTypes.func.isRequired
    tag: PropTypes.object.isRequired
    tagSlug: PropTypes.string.isRequired
    isFetched: PropTypes.bool.isRequired

  componentWillMount: ->
    @fetchTag()

  componentDidUpdate: ->
    @fetchTag()

  meta: ->
    {tag} = @props

    [
      { name: 'description', content: "Поиск / #{tag.name}" }
    ]

  fetchTag: ->
    @props.dispatch fetchTag(@props.tagSlug)

  fetchRatings: (page) ->
    @props.dispatch fetchTagRatings(@props.tagSlug, page)

  changePage: (page) ->
    @props.dispatch replaceState(null, "/tags/#{@props.tagSlug}", { page })

  previews: ->
    @ratings().map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    {isFetched} = @props

    <Layout isLoading={not isFetched}>
      <Helmet meta={@meta()}/>
      <div className="previews">
        {@previews()}
        {@showMore()}
      </div>
      {@pagination()}
    </Layout>

mapStateToProps = ({router, tagRatings, tag}, {tagSlug}) ->
  ratings: tagRatings.items
  tag: tag.item
  tagSlug: router.params.tagSlug
  page: parseInt(router.location.query?.page || 1)
  pagesCount: tagRatings.pagesCount
  isFetched: _.any [tagRatings, tag], 'isFetched'

module.exports = connect(mapStateToProps)(Tag)
