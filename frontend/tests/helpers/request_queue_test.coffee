chai = require 'chai'
RequestQueue = require '../../scripts/helpers/request_queue'

{expect} = chai

describe 'RequestQueue', ->
  beforeEach ->
    @queue = new RequestQueue

  it 'performs first given request', ->
    request = sinon.stub().returns(Promise.resolve())
    @queue.add request
    expect(request.calledOnce).to.be.true

  it 'performs second request when first one is finished', (done) ->
    promise = new Promise (@resolve) =>
    request1 = sinon.stub().returns(promise)
    request2 = sinon.stub().returns(Promise.resolve())
    @queue.add request1
    @queue.add request2
    expect(request2.called).to.be.false
    @resolve()
    setImmediate =>
      expect(request2.calledOnce).to.be.true
      done()

  describe '#cancel', ->
    it 'cancels request execution', (done) ->
      promise = new Promise (@resolve) =>
      request1 = sinon.stub().returns(promise)
      request2 = sinon.stub().returns(Promise.resolve())
      @queue.add request1
      @queue.add request2
      @queue.cancel request2
      @resolve()
      setImmediate =>
        expect(request2.called).to.be.false
        done()
