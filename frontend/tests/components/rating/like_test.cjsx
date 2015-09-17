_ = require 'lodash'
chai = require 'chai'
moment = require 'moment'
React = require 'react'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
Application = require '../../../scripts/application'
LikeContainer = require '../../../scripts/components/rating/like'
Meta = require '../../../scripts/components/shared/ratings/meta'

{expect} = chai
{InnerComponent: Like} = LikeContainer

describe 'Like', ->
  beforeEach ->
    @rating = id: '1', like: null, likesCount: 0, status: 'published', createdAt: moment(), publishedAt: moment(), slug: 'test', update: (data) -> _.merge @, data
    @app = TestUtils.createApplication Application,
      include: ['ratingsActions', 'ratingsStore', 'likesApi', 'popupsActions', 'popupsStore']
      stub:
        likesApi:
          create: sinon.stub().returns(Promise.resolve(body: { like: {}, meta: { likes_count: @rating.likesCount + 1 } }, status: 200))
    @app.ratingsStore.append @rating

  context 'logged in', ->
    beforeEach ->
      @currentUser = isLoggedIn: (-> true)

    it 'updates likes count after like', (done) ->
      createLikeTree = => testTree <Like currentUser={@currentUser}/>, context: { @app, @rating }
      createLikeTree().like.click()
      setImmediate =>
        metaTree = testTree <Meta/>, context: { @rating }
        expect(createLikeTree().counter.innerText).to.eq(@rating.likesCount.toString())
        expect(metaTree.likesCounter.innerText).to.eq(@rating.likesCount.toString())
        done()

  context 'not logged in', ->
    beforeEach ->
      @currentUser = isLoggedIn: (-> false)

    it 'shows login popup', (done) ->
      testTree(<Like currentUser={@currentUser}/>, context: { @app, @rating }).like.click()
      setImmediate =>
        actions = TestUtils.getDispatchedActionsWithType(@app, 'APPEND_POPUPS')
        expect(actions).to.have.length(1)
        done()
