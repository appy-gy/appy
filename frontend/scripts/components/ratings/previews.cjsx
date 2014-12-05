React = require 'react/addons'
RatingsStore = require '../../stores/ratings_store'
Preview = require './preview'

RatingsPreviews = React.createClass
  getInitialState: ->
    ratings = RatingsStore.getRatings()
    { ratings }

  render: ->
    {ratings} = @state

    previews = ratings.map (rating) ->
      <Preview key={rating.id} rating={rating} />

    <div>{previews}</div>

module.exports = RatingsPreviews
