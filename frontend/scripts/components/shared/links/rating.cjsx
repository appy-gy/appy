React = require 'react'
ModelLink = require '../../mixins/model_link'

{PropTypes} = React

modelLinkMixin = ModelLink 'rating',
  propTypes:
    rating: PropTypes.object.isRequired
  url: ({rating}) ->
    if rating.status == 'published'
      "/#{rating.section.slug}/#{rating.slug}"
    else
      "/ratings/#{rating.slug}/edit"

RatingLink = React.createClass
  mixins: [modelLinkMixin]

module.exports = RatingLink
