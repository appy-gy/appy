_ = require 'lodash'
React = require 'react/addons'
Listener = require '../mixins/listener'
Preview = require './preview'
RatingsStore = require '../../stores/ratings'

RatingsPreviews = React.createClass
  mixins: [Listener]

  getInitialState: ->
    ratings: @getRatings()

  componentWillMount: ->
    @addListener RatingsStore.addChangeListener(@updateRatings)

  getRatings: ->
    RatingsStore.getPage()

  updateRatings: ->
    @setState ratings: @getRatings()

  ratings: ->
    {ratings} = @state

    ratings.when
      pending: ->
        <div className="pending">Loading ratings...</div>
      failed: (error) ->
        <div className="error">Failed to load ratings. {error.message}</div>
      done: (ratings) ->
        _.map ratings, (rating) ->
          <Preview key={rating.id} rating={rating}/>

  render: ->
    <div className="previews">
      {@ratings()}
    </div>

module.exports = RatingsPreviews
