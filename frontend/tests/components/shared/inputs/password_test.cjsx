chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
PasswordInput = require '../../../../scripts/components/shared/inputs/password'

{expect} = chai

describe 'PasswordInput', ->
  describe 'show password button', ->
    it 'changes the password input type when clicked', ->
      inputTree = testTree <PasswordInput/>
      inputTree.trigger.click()
      expect(inputTree.input.getAttribute('type')).to.eq('text')
