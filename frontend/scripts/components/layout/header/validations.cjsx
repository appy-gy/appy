_ = require 'lodash'
React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'
Publish = require '../../shared/ratings/publish'

{PropTypes} = React

Validations = React.createClass
  displayName: 'Validations'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  render: ->
    {rating, ratingItems} = @props

    firstError = _.first prepublishValidation(rating, ratingItems)

    Component = if firstError
      firstError
    else
      <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>

    <div className="header_validation-error">
      {Component}
    </div>

module.exports = Validations
