_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
RatingsStore = require '../../stores/ratings'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'SectionRatings'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      <Preview key={rating.id} rating={rating} />

  render: ->
    <Layout>
      <div className="previews">
        {@previews()}
      </div>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: [RatingsStore]
  mixins: [ClearStores]

  fetch: ->
    {sectionSlug} = @props

    ratings: RatingsStore.for(@).getForSection(sectionSlug)

  pending: ->
    @done ratings: []
