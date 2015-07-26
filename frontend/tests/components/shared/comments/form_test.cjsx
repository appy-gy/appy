chai = require 'chai'
React = require 'react/addons'
Marty = require 'marty'
testTree = require 'react-test-tree'
TestUtils = require 'marty/test-utils'
Application = require '../../../../scripts/application'
FormContainer = require '../../../../scripts/components/shared/comments/form'

{expect} = chai
{fetch} = Marty
{InnerComponent: Form} = FormContainer

describe 'CommentForm', ->
  beforeEach ->
    @app = TestUtils.createApplication Application,
      include: ['commentsActions', 'commentsApi', 'commentsStore']
      stub:
        commentsApi:
          create: sinon.stub().returns(Promise.resolve(body: { comment: { id: 1 } }, status: 200))

  it 'cleans itself after submit', (done) ->
    user = avatarUrl: ->
    formTree = testTree <Form user={user}/>, context: { @app }
    formTree.bodyInput.value = 'test'
    formTree.bodyInput.simulate.keyDown key: 'Enter', shiftKey: true
    setImmediate =>
      expect(formTree.state.body).to.eq('')
      done()
