React = require 'react/addons'
classNames = require 'classnames'
CreateRating = require '../../shared/ratings/create'

{PropTypes} = React

CreateRatingButton = React.createClass
  displayName: 'CreateRatingButton'

  contextTypes:
    currentUser: PropTypes.object.isRequired

  render: ->
    {currentUser} = @context

    classes = classNames 'header_rating-button', 'm-authorized': currentUser.id?

    <CreateRating className={classes}>
      <span className="header_rating-button-icon">+</span>
      <span className="header_rating-button-text">
        Создать
      </span>
    </CreateRating>

module.exports = CreateRatingButton
