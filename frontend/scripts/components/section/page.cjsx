_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Loading = require '../mixins/loading'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
Section = require '../../models/section'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'SectionRatings'

  mixins: [Loading]

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    section: PropTypes.object.isRequired

  shouldShowLoader: ->
    {ratings} = @props

    _.isEmpty ratings

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      <Preview key={rating.id} rating={rating} imageSize="preview"/>

  render: ->
    {sectionSlug} = @props

    <Layout sectionSlug={sectionSlug}>
      <div className="previews">
        {@previews()}
      </div>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: ['ratingsStore', 'sectionsStore']

  mixins: [ClearStores(false)]

  fetch: ->
    {sectionSlug} = @props

    @clearStoresOnce()

    section: @app.sectionsStore.get(sectionSlug)
    ratings: @app.ratingsStore.getForSection(sectionSlug)
