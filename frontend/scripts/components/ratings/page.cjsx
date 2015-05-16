_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Subscription = require './subscription'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'Ratings'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  previewEnds:
    superLarge: 1
    large: 3
  subscriptionPosition: 1

  subscription: ->
    <Subscription key="subscription"/>

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      mod = _.findKey @previewEnds, (end) -> _.inRange index, end
      <Preview key={rating.id} rating={rating} mod={_.kebabCase mod}/>

  content: ->
    {ratings} = @props

    _.tap @previews(), (previews) =>
      previews.splice @subscriptionPosition, 0, @subscription()

  render: ->
    <Layout>
      <div className="previews">
        {@content()}
      </div>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: RatingsStore

  mixins: [ClearStores]

  fetch: ->
    ratings: RatingsStore.for(@).getPage()

  pending: ->
    @done ratings: []
