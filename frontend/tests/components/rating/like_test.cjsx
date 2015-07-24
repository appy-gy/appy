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

describe 'Like', ->
  beforeEach ->
    @rating = id: 'test', like: null, likesCount: 0, createdAt: moment(), slug: 'test', update: (data) -> _.merge @, data
    @app = TestUtils.createApplication Application,
      include: ['ratingsActions', 'ratingsStore', 'likesApi']
      stub:
        likesApi:
          create: sinon.stub().returns(Promise.resolve(body: { like: {}, meta: { likes_count: @rating.likesCount + 1 } }, status: 200))
    @app.ratingsStore.append @rating

  it 'updates likes count after like', (done) ->
    createLikeTree = => testTree <Like/>, context: { @app, @rating }
    createLikeTree().like.click()
    setImmediate =>
      metaTree = testTree <Meta/>, context: { @rating }
      expect(createLikeTree().counter.innerText).to.eq(@rating.likesCount.toString())
      expect(metaTree.likesCounter.innerText).to.eq(@rating.likesCount.toString())
      done()
