React = require 'react/addons'
RatingsStore = require '../../stores/ratings_store'
Marty = require 'marty'

RatingStateMixin = Marty.createStateMixin
  listenTo: RatingsStore
  getState: ->
    rating: RatingsStore.show @props.id

Rating = React.createClass
  mixins: [RatingStateMixin]

  render: ->
    <div className="rating">
      {@renderRating()}
    </div>

  renderRating: ->
    @state.rating.when
      pending: ->
        <div className='pending'>Loading rating...</div>
      failed: (error) ->
        <div className='error'>Failed to load rating. {error.message}</div>
      done: (rating) ->
        <div>{rating}</div>

module.exports = Rating
