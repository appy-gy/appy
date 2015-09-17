# To use this mixin your component should define following methods:
# fetchRatings, changePage

_ = require 'lodash'
React = require 'react'
KeepScroll = require './keep_scroll'
ShowMore = require '../shared/ratings/show_more'
Pagination = require '../shared/pagination/pagination'
PaginationLink = require '../shared/ratings/pagination_link'

{PropTypes} = React

RatingsList =
  mixins: [KeepScroll]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    page: PropTypes.number.isRequired
    pagesCount: PropTypes.number.isRequired

  childContextTypes:
    loadPage: PropTypes.func.isRequired

  getInitialState: ->
    visiblePages: [@props.page]

  getChildContext: ->
    { @loadPage }

  componentWillMount: ->
    @fetchRatings @props.page

  componentDidUpdate: ->
    @fetchRatings @props.page

  changeVisiblePages: (fn) ->
    @setState visiblePages: fn _.clone(@state.visiblePages)

  loadPage: (page) ->
    @changeVisiblePages -> [page]
    @changePage page

  loadNextPage: ->
    {page} = @props
    {visiblePages} = @state

    @changeVisiblePages (pages) -> pages.concat page + 1
    setImmediate => @keepScroll => @changePage page + 1

  ratings: ->
    {ratings} = @props
    {visiblePages} = @state

    _ ratings
      .filter (rating) -> _.includes visiblePages, rating.page
      .sortBy (rating) -> -Date.parse(rating.publishedAt)
      .value()

  showMore: ->
    {page, pagesCount} = @props

    return if page >= pagesCount
    <ShowMore onClick={@loadNextPage}/>

  pagination: ->
    {page, pagesCount} = @props

    <Pagination currentPage={page} pagesCount={pagesCount} link={PaginationLink}/>

module.exports = RatingsList
