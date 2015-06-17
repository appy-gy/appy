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

  contextTypes:
    router: PropTypes.func.isRequired

  childContextTypes:
    ratingSlug: PropTypes.string.isRequired
    block: PropTypes.string.isRequired

  getChildContext: ->
    {ratingSlug} = @props

    { ratingSlug, block: 'rating' }

  rating: ->
    {ratingSlug} = @props

    findInStore @app.ratingsStore, ratingSlug

  componentWillUpdate: ->
    {ratingSlug} = @props
    {router} = @context
    rating = @rating()

    return if not rating? or ratingSlug == rating.slug or router.getCurrentParams().ratingSlug == rating.slug

    setImmediate -> router.replaceWith 'rating', ratingSlug: rating.slug

  sectionSlug: ->
    {ratingSlug} = @props

    _.get @rating(), 'section.slug', 'default'

  render: ->
    {ratingSlug} = @props

    <Layout header="rating" sectionSlug={@sectionSlug()}>
      <Rating/>
      <Comments/>
    </Layout>

module.exports = Marty.createContainer RatingPage,
  listenTo: ['ratingsStore']
