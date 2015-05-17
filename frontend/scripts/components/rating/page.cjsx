React = require 'react/addons'
ClearStores = require '../mixins/clear_stores'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  mixins: [ClearStores]

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingSlug} = @props

    { ratingSlug, block: 'rating' }

  render: ->
    <Layout header="rating">
      <Rating/>
      <Comments/>
    </Layout>

module.exports = RatingPage
