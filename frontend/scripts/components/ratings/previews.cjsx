React = require 'react/addons'
{RatingsStorage} = require '../../storages'
Preview = require './preview'

RatingsPreviews = React.createClass
  getInitialState: ->
    ratings = RatingsStorage.getRatings()
    { ratings }

  render: ->
    {ratings} = @state

    previews = ratings.map (rating) ->
      <Preview key={rating.id} rating={rating} />

    <div>{previews}</div>

module.exports = RatingsPreviews
