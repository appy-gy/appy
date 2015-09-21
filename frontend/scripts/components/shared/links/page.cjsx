React = require 'react'
ModelLink = require '../../mixins/model_link'

PageLink = React.createClass
  mixins: [ModelLink('page')]

module.exports = PageLink
