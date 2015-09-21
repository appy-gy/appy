React = require 'react'
ModelLink = require '../../mixins/model_link'

UserLink = React.createClass
  mixins: [ModelLink('user')]

module.exports = UserLink
