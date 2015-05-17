_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

UserLink = React.createClass
  displayName: 'UserLink'

  propTypes:
    user: PropTypes.object
    slug: PropTypes.string
    children: PropTypes.node.isRequired

  slug: ->
    {user, slug} = @props

    slug or user.slug

  render: ->
    {children} = @props

    props = _.omit @props, 'user', 'slug', 'children'

    <Link to="user" params={userSlug: @slug()} {...props}>
      {children}
    </Link>

module.exports = UserLink
