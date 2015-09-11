# To use this mixin your component should define following methods:
# fetchRatings, page, pagesCount, changePage

_ = require 'lodash'
React = require 'react/addons'
KeepScroll = require './keep_scroll'
ShowMore = require '../shared/ratings/show_more'
Pagination = require '../shared/pagination/pagination'
PaginationLink = require '../shared/ratings/pagination_link'

{PropTypes} = React

RatingsList =
  mixins: [KeepScroll]

  childContextTypes:
    loadPage: PropTypes.func.isRequired

  getInitialState: ->
    visiblePages: [@page()]

  getChildContext: ->
    { @loadPage }

  componentWillMount: ->
    @fetchRatings @page()

  componentWillUpdate: ->
    @prevPage = @page()

  componentDidUpdate: ->
    return if @prevPage == @page()
    @fetchRatings @page()

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

  showMore: ->
    return if @page() >= @pagesCount()

    <ShowMore onClick={@loadNextPage}/>

  pagination: ->
    <Pagination currentPage={@page()} pagesCount={@pagesCount()} link={PaginationLink}/>

module.exports = RatingsList
