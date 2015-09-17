_ = require 'lodash'
React = require 'react'
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
    children: PropTypes.node

  contextTypes:
    router: PropTypes.func.isRequired

  getDefaultProps: ->
    isActive: false

  render: ->
    {block, to, query, params, isActive, children} = @props

    classes = @classes "#{block}_link", 'm-active': isActive

    props = _.omit @props, 'block','className', 'isActive', 'children'

    <Link className={classes} {...props}>
      {children}
    </Link>

module.exports = PaginationLink
