_ = require 'lodash'
chai = require 'chai'
moment = require 'moment'
React = require 'react/addons'
Marty = require 'marty'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
mockComponents = require '../helpers/mock_components'
Application = require '../../scripts/application'
CommentsContainer = require '../../scripts/components/rating/comments'
UserLink = require '../../scripts/components/shared/links/user'

{expect} = chai
{fetch} = Marty
{InnerComponent: Comments} = CommentsContainer

buildUser = ->
  id: _.uniqueId('userId'), avatarUrl: (->)

buildComment = ->
  id: _.uniqueId('commentId')
  shortId: _.constant _.uniqueId('commentShortId')
  createdAt: moment()
  user: buildUser()

describe 'Comments', ->
  describe 'behavior after submit', ->
    before ->
      @restoreComponents = mockComponents UserLink

    beforeEach ->
      currentUser = buildUser()
      rating = canSeeComments: true, canComment: true, slug: 'test'
      comments = [buildComment()]
      router = getCurrentQuery: -> {}

      app = TestUtils.createApplication Application,
        include: ['currentUserStore', 'commentsActions', 'commentsApi', 'commentsStore']
        stub:
          commentsApi:
            create: sinon.stub().returns(Promise.resolve(body: { comment: buildComment() }, status: 200))
      sinon.stub(app.currentUserStore, 'get').returns(fetch.done(currentUser))

      @commentsTree = testTree <Comments rating={rating} comments={comments}/>, context: { app, router }

    after ->
      @restoreComponents()

    it 'keeps form visible if submits root comment', (done) ->
      {bodyInput} = @commentsTree.form.innerComponent
      bodyInput.value = 'test'
      bodyInput.simulate.keyDown key: 'Enter', shiftKey: true
      setImmediate =>
        expect(@commentsTree.form).not.to.be.undefined
        done()

    it 'hides form if submits answer to another comment', ->
      {answer} = @commentsTree.trees[0].comment.actions
      answer.trigger.click()
      {bodyInput} = answer.form.innerComponent
      bodyInput.value = 'test'
      bodyInput.simulate.keyDown key: 'Enter', shiftKey: true
      expect(answer.form).to.be.undefined
