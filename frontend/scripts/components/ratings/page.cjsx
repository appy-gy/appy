_ = require 'lodash'
React = require 'react/addons'
Listener = require '../mixins/listener'
Preview = require './preview'
Subscription = require './subscription'
RatingsStore = require '../../stores/ratings'

{PureRenderMixin} = React.addons

Ratings = React.createClass
  displayName: 'Ratings'

  mixins: [PureRenderMixin, Listener]

  previewEnds:
    superLarge: 1
    large: 3
  subscriptionPosition: 1

  getInitialState: ->
    ratings: @getRatings()

  componentWillMount: ->
    @addListener RatingsStore.addChangeListener(@updateRatings)

  getRatings: ->
    RatingsStore.getPage()

  updateRatings: ->
    @setState ratings: @getRatings()

  subscription: ->
    <Subscription key="subscription"/>

  previews: ->
    {ratings} = @state

    ratings.result.map (rating, index) =>
      mod = _.findKey @previewEnds, (end) -> _.inRange index, end
      <Preview key={rating.id} rating={rating} mod={_.kebabCase mod}/>

  content: ->
    {ratings} = @state

    ratings.when
      pending: ->
        <div className="pending">Loading ratings...</div>
      failed: (error) ->
        <div className="error">Failed to load ratings. {error.message}</div>
      done: =>
        _.tap @previews(), (previews) =>
          previews.splice @subscriptionPosition, 0, @subscription()

  render: ->
    <div className="previews">
      {@content()}
    </div>

module.exports = Ratings
