chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
mockComponents = require '../helpers/mock_components'
Application = require '../../scripts/application'
Layout = require '../../scripts/components/layout/layout'
UserContainer = require '../../scripts/components/user/page'
Avatar = require '../../scripts/components/user/avatar'
RatingTabs = require '../../scripts/components/user/rating_tabs'
Comments = require '../../scripts/components/user/comments'

{expect} = chai
{InnerComponent: User} = UserContainer

describe 'User slug update', ->
  before ->
    @restore = mockComponents Layout, Avatar, RatingTabs, Comments

  after ->
    @restore()

  beforeEach ->
    @user = id: '1', slug: '1', isLoggedIn: (-> true)
    @router = getCurrentQuery: (-> {}), getCurrentParams: (-> userSlug: '1')
    @app = TestUtils.createApplication Application,
      include: ['usersApi', 'usersQueries', 'usersStore',
        'currentUserApi', 'currentUserQueries', 'currentUserStore']
      stub:
        usersApi:
          load: sinon.stub().returns(Promise.resolve(body: { @user }, status: 200))
        currentUserApi:
          load: sinon.stub().returns(Promise.resolve(body: { @user }, status: 200))
    @app.usersStore.append @user

  it.only 'replaces current route on change', (done) ->
    @router.replaceWith = sinon.spy()

    userContainerTree = testTree <UserContainer userSlug={@user.slug}/>, context: { @app, @router }
    TestUtils.dispatch @app, 'REPLACE_USER', id: '1', slug: 'test'

    setImmediate =>
      setImmediate =>
        expect(@router.replaceWith.calledWith 'user', userSlug: 'test').to.be.true
        done()
