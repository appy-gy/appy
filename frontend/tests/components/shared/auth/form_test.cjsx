chai = require 'chai'
React = require 'react/addons'
testTree = require 'react-test-tree'
Form = require '../../../../scripts/components/shared/auth/form'

{expect} = chai

describe 'AuthForm', ->
  describe 'show password button', ->
    it 'changes the password input type when clicked', ->
      form = testTree <Form/>
      form.showPasswordButton.click()
      expect(form.passwordInput.getAttribute('type')).to.eq('text')
