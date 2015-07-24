chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
Publish = require '../../../../scripts/components/shared/ratings/publish'

{expect} = chai

describe 'Publish', ->
  it 'has disabled modifactor when rating can not be published', ->
    rating = {}
    ratingItems = []
    publishTree = testTree <Publish rating={rating} ratingItems={ratingItems}/>
    expect(publishTree.getClassName()).to.string('m-disabled')

  it 'has not disabled modifactor when rating can be published', ->
    rating = title: 'test', description: 'test'
    ratingItems = [{}, {}]
    publishTree = testTree <Publish rating={rating} ratingItems={ratingItems}/>
    expect(publishTree.getClassName()).not.to.string('m-disabled')
