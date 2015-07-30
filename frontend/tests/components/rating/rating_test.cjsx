_ = require 'lodash'
chai = require 'chai'
moment = require 'moment'
React = require 'react/addons'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
mockComponents = require '../../helpers/mock_components'
Application = require '../../../scripts/application'
RatingContainer = require '../../../scripts/components/rating/rating'
Header = require '../../../scripts/components/rating/header'
UserLink = require '../../../scripts/components/shared/links/user'

{expect} = chai
{InnerComponent: Rating} = RatingContainer

describe 'Rating', ->
  describe 'elements visibility', ->
    before ->
      @restoreComponents = mockComponents Header, UserLink

    after ->
      @restoreComponents()

    beforeEach ->
      @rating = createdAt: moment(), imageUrl: (->), user: {}
      @ratingItems = []
      @app = TestUtils.createApplication Application,
        include: ['currentUserQueries', 'currentUserApi', 'currentUserStore']
        stub:
          currentUserApi:
            load: sinon.stub().returns(Promise.resolve(body: { user: {} }, status: 200))

    context 'rating is published', ->
      beforeEach ->
        @rating.status = 'published'
        @ratingTree = testTree <Rating rating={@rating} ratingItems={@ratingItems}/>, context: { @app, canEdit: true }

      ['authorLink', 'likeButton', 'shareButtons'].each (name) ->
        it "shows #{_.startCase name}", ->
          expect(@ratingTree[name]).not.to.be.undefined

    context 'rating is draft', ->
      beforeEach ->
        @rating.status = 'draft'
        @ratingTree = testTree <Rating rating={@rating} ratingItems={@ratingItems}/>, context: { @app, canEdit: true }

      ['authorLink', 'likeButton', 'shareButtons'].each (name) ->
        it "shows #{_.startCase name}", ->
          expect(@ratingTree[name]).to.be.undefined

  describe 'draft access', ->
    before ->
      @restoreComponents = mockComponents Rating

    after ->
      @restoreComponents()

    beforeEach ->
      @app = TestUtils.createApplication Application,
        include: ['ratingsActions', 'ratingsApi', 'ratingsQueries', 'ratingsStore',
          'ratingItemsActions', 'ratingItemsApi', 'ratingItemsQueries', 'ratingItemsStore']
        stub:
          ratingsApi:
            load: sinon.stub().returns(Promise.resolve(body: { rating: { status: 'draft', slug: 'test' } }, status: 200))
          ratingItemsApi:
            loadForRating: sinon.stub().returns(Promise.resolve(body: { rating_items: [] }, status: 200))

    it 'redirects if user without access tries to open it', (done) ->
      router = replaceWith: sinon.spy()
      ratingContainerTree = testTree <RatingContainer/>, context: { @app, router, canEdit: false, ratingSlug: 'test' }
      setImmediate =>
        setImmediate =>
          expect(router.replaceWith.calledWith('root')).to.be.true
          done()
