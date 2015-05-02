React = require 'react/addons'
Marty = require 'marty'
Preview = require '../shared/ratings/preview'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  ratings: ->
    {ratings} = @props

    ratings.map (rating) ->
      <Preview key={rating.key} rating={rating}/>

  render: ->
    {ratings} = @props

    <div>
      <h2 className="user-profile_tab-header">Ваши рейтинги<span> (34)</span></h2>
      <p>
        У вас пока нет рейтингов. Создайте свой первый рейтинг прямо сейчас!
      </p>
      <a href='/' className="user-profile_tab-button">
        Создать рейтинг
      </a>
      {@ratings()}
    </div>

module.exports = Marty.createContainer Ratings,
  listenTo: RatingsStore

  contextTypes:
    user: PropTypes.object.isRequired

  fetch: ->
    {user} = @context

    ratings: RatingsStore.for(@).getForUser(user.id)
