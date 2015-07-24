_ = require 'lodash'
chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
mockComponents = require '../../../helpers/mock_components'
Pagination = require '../../../../scripts/components/shared/pagination/pagination'
Link = require '../../../../scripts/components/shared/pagination/link'

{expect} = chai

createPagination = (props) ->
  testTree <Pagination link={Link} {...props}/>

getPages = (pagination) ->
  _.transform ['left', 'central', 'right'], (result, position) ->
    window = pagination["#{position}Window"]
    return unless window?
    pages = window.map (link) -> link.getProp 'page'
    result[position] = pages
  , {}

describe 'Pagination', ->
  before ->
    @restoreComponents = mockComponents Link

  after ->
    @restoreComponents()

  describe 'previous page link', ->
    it 'should not show on a first page', ->
      paginationTree = createPagination currentPage: 1, pagesCount: 10
      expect(paginationTree.prevPageLink).to.be.undefined

    it 'should show on other pages', ->
      paginationTree = createPagination currentPage: 5, pagesCount: 10
      expect(paginationTree.prevPageLink).not.to.be.undefined

  describe 'next page link', ->
    it 'should not show on a last page', ->
      paginationTree = createPagination currentPage: 10, pagesCount: 10
      expect(paginationTree.nextPageLink).to.be.undefined

    it 'should show on other pages', ->
      paginationTree = createPagination currentPage: 5, pagesCount: 10
      expect(paginationTree.nextPageLink).not.to.be.undefined

  context 'zero pages', ->
    before ->
      @paginationTree = createPagination currentPage: 1, pagesCount: 0

    it 'pages should not be visible', ->
      expect(getPages(@paginationTree)).to.be.empty

    it 'prev should not be visible', ->
      expect(@paginationTree.prevPageLink).to.be.undefined

    it 'next should not be visible', ->
      expect(@paginationTree.nextPageLink).to.be.undefined

  context 'only one page', ->
    it 'should not be visible', ->
      paginationTree = createPagination currentPage: 1, pagesCount: 1
      expect(getPages(paginationTree)).to.be.empty

  context 'on a first page', ->
    it 'only one page', ->
      paginationTree = createPagination currentPage: 1, pagesCount: 1
      expect(getPages(paginationTree)).to.be.empty

    it 'pages count less than a half of window size', ->
      paginationTree = createPagination currentPage: 1, pagesCount: 3
      expect(getPages(paginationTree)).to.be.deep.equal(central: [1..3])

    it 'pages count greater than a half of window size', ->
      paginationTree = createPagination currentPage: 1, pagesCount: 7
      expect(getPages(paginationTree)).to.be.deep.equal(central: [1..4], right: [7])

  context 'in the middle', ->
    it 'shows all windows', ->
      paginationTree = createPagination currentPage: 10, pagesCount: 20
      expect(getPages(paginationTree)).to.be.deep.equal(left: [1], central: [7..13], right: [20])

  context 'on a last page', ->
    it 'pages count less than a half of window size', ->
      paginationTree = createPagination currentPage: 3, pagesCount: 3
      expect(getPages(paginationTree)).to.be.deep.equal(central: [1..3])

    it 'pages count greater than a half of window size', ->
      paginationTree = createPagination currentPage: 7, pagesCount: 7
      expect(getPages(paginationTree)).to.be.deep.equal(left: [1], central: [4..7])
