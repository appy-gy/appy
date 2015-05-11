_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Preview = require '../shared/ratings/preview'
CreateRating = require '../shared/ratings/create'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  noRatings: ->
    {ratings} = @props

    return unless _.isEmpty ratings

    <div>
      У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!
    </div>

  ratings: ->
    {ratings} = @props

    ratings.map (rating) ->
      <Preview key={rating.key} rating={rating}/>

  render: ->
    {ratings} = @props

    <div>
      <h2 className="user-profile_tab-header">
        Ваши рейтинги ({ratings.length})
      </h2>
      {@noRatings()}
      <CreateRating className="user-profile_tab-button">
        Создать рейтинг
      </CreateRating>
      {@ratings()}
    </div>

module.exports = Marty.createContainer Ratings,
  listenTo: RatingsStore

  contextTypes:
    userId: PropTypes.string.isRequired

  fetch: ->
    {userId} = @context

    ratings: RatingsStore.for(@).getForUser(userId)
