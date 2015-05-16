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

  contextTypes:
    user: PropTypes.object.isRequired

  noRatings: ->
    return if @hasRatings()

    <div>
      У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!
    </div>

  createRating: ->
    {user} = @context

    return if @hasRatings()

    <CreateRating className="user-profile_tab-button">
      Создать рейтинг
    </CreateRating>

  hasRatings: ->
    {user} = @context

    user.ratingsCount > 0

  ratings: ->
    {ratings} = @props

    ratings.map (rating) ->
      <Preview key={rating.id} rating={rating}/>

  render: ->
    {user} = @context

    <div>
      <h2 className="user-profile_tab-header">
        Ваши рейтинги ({user.ratingsCount})
      </h2>
      {@noRatings()}
      {@createRating()}
      <div className="previews">
        {@ratings()}
      </div>
    </div>

module.exports = Marty.createContainer Ratings,
  listenTo: RatingsStore

  contextTypes:
    userId: PropTypes.string.isRequired

  fetch: ->
    {userId} = @context

    ratings: RatingsStore.for(@).getForUser(userId)
