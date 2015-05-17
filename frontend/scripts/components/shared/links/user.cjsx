_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'

{PropTypes} = React
{Link} = Router

UserLink = React.createClass
  displayName: 'UserLink'

  propTypes:
    user: PropTypes.object.isRequired
    children: PropTypes.node.isRequired

  render: ->
    {user, children} = @props

    props = _.omit @props, 'user', 'children'

    <Link className="comment_username" to="user" params={userSlug: user.slug} {...props}>
      {children}
    </Link>

module.exports = UserLink
