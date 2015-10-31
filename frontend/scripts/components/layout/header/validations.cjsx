React = require 'react'
PureRendexMixin = require 'react-addons-pure-render-mixin'
CSSTransitionGroup = require 'react-addons-css-transition-group'
prepublishValidation = require '../../../helpers/ratings/prepublish_validation'

{PropTypes} = React

Validations = React.createClass
  displayName: 'Validations'

  mixins: [PureRendexMixin]

  propTypes:
    rating: PropTypes.object.isRequired
    ratingItems: PropTypes.arrayOf(PropTypes.object).isRequired

  errors: ->
    {rating, ratingItems} = @props

    prepublishValidation(rating, ratingItems).map (error) ->
      <div key={error} className="header_validation-error">
        {error}
      </div>

  render: ->
    <CSSTransitionGroup className="header_validation-errors" transitionName="m" transitionEnterTimeout={500} transitionLeaveTimeout={3000}>
      {@errors()}
    </CSSTransitionGroup>

module.exports = Validations
