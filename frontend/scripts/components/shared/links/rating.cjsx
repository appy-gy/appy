_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

RatingLink = React.createClass
  displayName: 'RatingLink'

  propTypes:
    rating: PropTypes.object
    slug: PropTypes.string
    children: PropTypes.node.isRequired

  slug: ->
    {rating, slug} = @props

    slug or rating.slug

  render: ->
    {children} = @props

    props = _.omit @props, 'rating', 'slug', 'children'

    <Link to="rating" params={ratingSlug: @slug()} {...props}>
      {children}
    </Link>

module.exports = RatingLink
