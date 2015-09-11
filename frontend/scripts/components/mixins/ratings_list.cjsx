# To use this mixin your component should define following methods:
# fetchRatings, page, changePage

_ = require 'lodash'
React = require 'react/addons'
Watch = require './watch'
KeepScroll = require './keep_scroll'
ShowMore = require '../shared/ratings/show_more'
Pagination = require '../shared/pagination/pagination'
PaginationLink = require '../shared/ratings/pagination_link'

{PropTypes} = React

RatingsList =
  mixins: [Watch, KeepScroll]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    pagesCount: PropTypes.number.isRequired

  childContextTypes:
    loadPage: PropTypes.func.isRequired

  getInitialState: ->
    visiblePages: [@page()]

  getChildContext: ->
    { @loadPage }

  componentWillMount: ->
    @fetchRatings @page()

    @watch
      exp: @page
      onChange: => @fetchRatings @page()

  changeVisiblePages: (fn) ->
    @setState visiblePages: fn _.clone(@state.visiblePages)

  loadPage: (page) ->
    @changeVisiblePages -> [page]
    @changePage page

  loadNextPage: ->
    {visiblePages} = @state

    page = @page() + 1

    @changeVisiblePages (pages) -> pages.concat page
    setImmediate => @keepScroll => @changePage page

  ratings: ->
    {ratings} = @props
    {visiblePages} = @state

    _ ratings
      .filter (rating) -> _.includes visiblePages, rating.page
      .sortBy (rating) -> -Date.parse(rating.publishedAt)
      .value()

  showMore: ->
    {pagesCount} = @props

    return if @page() >= pagesCount
    <ShowMore onClick={@loadNextPage}/>

  pagination: ->
    {pagesCount} = @props

    <Pagination currentPage={@page()} pagesCount={pagesCount} link={PaginationLink}/>

module.exports = RatingsList
