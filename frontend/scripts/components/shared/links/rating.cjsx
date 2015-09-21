React = require 'react'
ModelLink = require '../../mixins/model_link'

RatingLink = React.createClass
  mixins: [ModelLink('rating')]

module.exports = RatingLink
