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

    validations = prepublishValidation(rating, ratingItems)

    firstError = _.first validations.errors
    counterText = "#{validations.errorsTotal - validations.errors.length} / #{validations.errorsTotal}"

    Component = if firstError
      firstError
    else
      <Publish ref="publish" rating={rating} ratingItems={ratingItems}/>

    <div className="header_validation">
      <span className="header_validation-error">
        {Component}
      </span>
      <span className="header_validation-counter">
        {counterText}
      </span>
    </div>

module.exports = Validations
