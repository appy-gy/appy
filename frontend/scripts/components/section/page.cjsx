React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Layout = require '../layout/layout'
Preview = require '../shared/ratings/preview'
Section = require '../../models/section'

{PropTypes} = React

Ratings = React.createClass
  displayName: 'SectionRatings'

  propTypes:
    ratings: PropTypes.arrayOf(PropTypes.object).isRequired
    section: PropTypes.object.isRequired

  previews: ->
    {ratings} = @props

    ratings.map (rating, index) =>
      <Preview key={rating.id} rating={rating} />

  render: ->
    {sectionSlug} = @props

    <Layout sectionSlug={sectionSlug}>
      <div className="previews">
        {@previews()}
      </div>
    </Layout>

module.exports = Marty.createContainer Ratings,
  listenTo: ['ratingsStore', 'sectionsStore']

  mixins: [ClearStores()]

  fetch: ->
    {sectionSlug} = @props

    section: @app.sectionsStore.get(sectionSlug)
    ratings: @app.ratingsStore.getForSection(sectionSlug)
