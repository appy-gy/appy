chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
Application = require '../../scripts/application'
Popups = require '../../scripts/components/layout/popups/popups'
Login = require '../../scripts/components/shared/auth/login'

{expect} = chai

describe 'Login', ->
  beforeEach ->
    @app = TestUtils.createApplication Application,
      include: ['popupsActions', 'popupsStore', 'currentUserActions', 'currentUserApi', 'currentUserStore']
      stub:
        currentUserApi:
          logIn: sinon.stub().returns(Promise.resolve(body: { user: { id: '1' } }, status: 200))

  it 'hides popup after login', (done) ->
    loginTree = testTree <Login/>, context: { @app }
    loginTree.click()
    popup = @app.popupsStore.getState()[0]
    popupTree = testTree popup.content
    popupTree.form.simulate.submit()
    setImmediate =>
      expect(TestUtils.hasDispatched(@app, 'REMOVE_POPUPS', [popup])).to.be.true
      done()
