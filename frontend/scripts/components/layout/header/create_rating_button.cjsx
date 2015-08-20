React = require 'react/addons'
Marty = require 'marty'
classNames = require 'classnames'
CreateRating = require '../../shared/ratings/create'

{PropTypes} = React

CreateRatingButton = React.createClass
  displayName: 'CreateRatingButton'

  propTypes:
    currentUser: PropTypes.object.isRequired

  render: ->
    {currentUser} = @props

    classes = classNames 'header_rating-button', 'm-authorized': currentUser.isLoggedIn()

    <CreateRating className={classes}>
      <span className="header_rating-button-icon">+</span>
      <span className="header_rating-button-text">
        Создать
      </span>
    </CreateRating>

module.exports = Marty.createContainer CreateRatingButton,
  listenTo: 'currentUserStore'

  fetch: ->
    currentUser: @app.currentUserStore.get()
