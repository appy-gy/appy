React = require 'react/addons'
Rating = require './rating'
Comments = require './comments'
Layout = require '../layout/layout'

{PropTypes} = React

RatingPage = React.createClass
  displayName: 'RatingPage'

  childContextTypes:
    ratingId: PropTypes.string.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingId} = @props

    { ratingId, block: 'rating' }

  render: ->
    <Layout header="rating">
      <Rating/>
      <Comments/>
    </Layout>

module.exports = RatingPage
