_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
Preview = require '../shared/ratings/preview'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

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
      <h2 className="user-profile_tab-header">Ваши рейтинги<span> (34)</span></h2>
      {@noRatings()}
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
