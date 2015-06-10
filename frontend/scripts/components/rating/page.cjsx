React = require 'react/addons'
Marty = require 'marty'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [Marty.createAppMixin()]

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingSlug} = @props

    { ratingSlug, block: 'rating' }

  render: ->
    {ratingSlug, rating} = @props

    <Layout header="rating" sectionSlug={rating.section.slug}>
      <Rating/>
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore']

  fetch: ->
    {ratingSlug} = @props

    rating: @app.ratingsStore.get(ratingSlug)
