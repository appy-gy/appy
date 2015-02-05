_ = require 'lodash'
React = require 'react/addons'
RatingsStore = require '../../stores/ratings_store'
Preview = require './preview'
Marty = require 'marty'

RatingsStateMixin = Marty.createStateMixin
  listenTo: RatingsStore
  getState: ->
    ratings: RatingsStore.index()

RatingsPreviews = React.createClass
  mixins: [RatingsStateMixin]

  render: ->
    <div className="ratings">
      {@renderRatings()}
    </div>

  renderRatings: ->
    @state.ratings.when
      pending: ->
        <div className='pending'>Loading ratings...</div>
      failed: (error) ->
        <div className='error'>Failed to load ratings. {error.message}</div>
      done: (ratings) ->
        _.map ratings, (rating) ->
          <Preview key={rating.id} rating={rating}/>

module.exports = RatingsPreviews
