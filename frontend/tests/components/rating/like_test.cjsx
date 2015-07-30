_ = require 'lodash'
chai = require 'chai'
moment = require 'moment'
React = require 'react/addons'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
Application = require '../../../scripts/application'
Like = require '../../../scripts/components/rating/like'
Meta = require '../../../scripts/components/shared/ratings/meta'

{expect} = chai

describe.only 'Like', ->
  beforeEach ->
    @rating = id: '1', like: null, likesCount: 0, createdAt: moment(), slug: 'test', update: (data) -> _.merge @, data
    @app = TestUtils.createApplication Application,
      include: ['currentUserStore', 'ratingsActions', 'ratingsStore', 'likesApi', 'popupsActions', 'popupsStore']
      stub:
        likesApi:
          create: sinon.stub().returns(Promise.resolve(body: { like: {}, meta: { likes_count: @rating.likesCount + 1 } }, status: 200))
    @app.ratingsStore.append @rating

  context 'logged in', ->
    before ->
      currentUser = id: _.uniqueId('userId'), isLoggedIn: (-> true)
      @restore = sinon.stub(@app.currentUserStore, 'get').returns(fetch.done(currentUser))

    after ->
      @restore()

    it 'updates likes count after like', (done) ->
      createLikeTree = => testTree <Like/>, context: { @app, @rating }
      createLikeTree().like.click()
      setImmediate =>
        metaTree = testTree <Meta/>, context: { @rating }
        expect(createLikeTree().counter.innerText).to.eq(@rating.likesCount.toString())
        expect(metaTree.likesCounter.innerText).to.eq(@rating.likesCount.toString())
        done()

  context 'not logged in', ->
    it 'shows login popup', ->
      testTree(<Like/>, context: { @app, @rating }).like.click()
      expect(TestUtils.hasDispatched(@app, "APPEND_POPUPS").to.be.true
