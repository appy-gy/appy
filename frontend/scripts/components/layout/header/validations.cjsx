React = require 'react/addons'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'

{PropTypes} = React
{CSSTransitionGroup} = React.addons

Validations = React.createClass
  displayName: 'Validations'

  contextTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  publishErrors: ->
    {rating, ratingItems} = @context

    prepublishValidation rating, ratingItems

  errors: ->
    {rating, ratingItems} = @context

    prepublishValidation(rating, ratingItems).map (error) ->
      <div key={error} className="header_validation-error">
        {error}
      </div>

  render: ->
    <div className="header_validation-errors">
      <CSSTransitionGroup transitionName="header_validation-errors">
        {@errors()}
      </CSSTransitionGroup>
    </div>

module.exports = Validations
