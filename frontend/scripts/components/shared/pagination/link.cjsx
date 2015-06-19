_ = require 'lodash'
React = require 'react/addons'
Router = require 'react-router'
Classes = require '../../mixins/classes'

{PropTypes} = React
{Link} = Router

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  mixins: [Classes]

  propTypes:
    block: PropTypes.string.isRequired
    page: PropTypes.number.isRequired
    to: PropTypes.string.isRequired
    query: PropTypes.object
    params: PropTypes.object
    isActive: PropTypes.bool
    children: PropTypes.node.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  getDefaultProps: ->
    isActive: false

  render: ->
    {block, to, query, params, isActive, children} = @props

    classes = @classes "#{block}_link", 'm-active': isActive

    <Link className={classes} to={to} query={query} params={params}>
      {children}
    </Link>

module.exports = PaginationLink
