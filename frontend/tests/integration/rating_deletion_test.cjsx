chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
Application = require '../../scripts/application'
RatingActions = require '../../scripts/components/layout/header/rating_actions'
PopupsContainer = require '../../scripts/components/layout/popups/popups'

{expect} = chai

describe 'Rating deletion', ->
  beforeEach ->
    @user = slug: 'test'
    @rating = {}
    @ratingItems = []
    @router = {}

    @app = TestUtils.createApplication Application,
      include: ['popupsActions', 'popupsStore', 'currentUserStore']

    @app.currentUserStore.set @user

  it 'redirects to user profile after', ->
    @router.replaceWith = sinon.spy()

    actionsTree = testTree <RatingActions/>, context: { @app, @router, @user, @rating, @ratingItems }
    actionsTree.delete.getProp('onDelete')()

    expect(@router.replaceWith.calledWith 'user', userSlug: 'test').to.be.true
