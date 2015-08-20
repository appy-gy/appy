React = require 'react/addons'
ShowMore = require '../shared/ratings/show_more'
Pagination = require '../shared/pagination/pagination'
PaginationLink = require '../shared/ratings/pagination_link'

{PropTypes} = React

RatingsList =
  contextTypes:
    page: PropTypes.number.isRequired

  childContextTypes:
    changeVisiblePages: PropTypes.func.isRequired

  getInitialState: ->
    {page} = @context

    visiblePages: new Set [page]

  getChildContext: ->
    { @changeVisiblePages }

  changeVisiblePages: (fn) ->
    {visiblePages} = @state

    @setState visiblePages: fn visiblePages

  pagesCount: ->
    @app.pageCountsStore.get(@pagesCountKey()) || 0

  showMore: ->
    {page} = @context

    return if page >= @pagesCount()

    <ShowMore/>

  pagination: ->
    {page} = @context

    <Pagination currentPage={page} pagesCount={@pagesCount()} link={PaginationLink}/>

module.exports = RatingsList
