React = require 'react'
ModelLink = require '../../mixins/model_link'

SectionLink = React.createClass
  mixins: [ModelLink('section')]

module.exports = SectionLink
