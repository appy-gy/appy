_ = require 'lodash'
React = require 'react/addons'
Marty = require 'marty'
ClearStores = require '../mixins/clear_stores'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'
findInStore = require '../../helpers/find_in_store'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [Marty.createAppMixin(), ClearStores]

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingSlug} = @props

    { ratingSlug, block: 'rating' }

  sectionSlug: ->
    {ratingSlug} = @props

    rating = findInStore @app.ratingsStore, ratingSlug
    _.get rating, 'section.slug', 'default'

  render: ->
    {ratingSlug} = @props

    <Layout header="rating" sectionSlug={@sectionSlug()}>
      <Rating/>
      <Comments/>
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore']
