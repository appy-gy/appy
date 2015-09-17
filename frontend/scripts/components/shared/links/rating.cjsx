React = require 'react'
ModelLink = require '../../mixins/model_link'

{PropTypes} = React

RatingLink = React.createClass
  displayName: 'RatingLink'

  mixins: [ModelLink]

  propTypes:
    rating: PropTypes.object

  objectName: 'rating'

module.exports = RatingLink
