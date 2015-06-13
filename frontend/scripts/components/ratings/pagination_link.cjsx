React = require 'react/addons'
Router = require 'react-router'
Classes = require '../mixins/classes'

{PropTypes} = React
{Link} = Router

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  mixins: [Classes]

  propTypes:
    block: PropTypes.string.isRequired
    page: PropTypes.number.isRequired
    isActive: PropTypes.bool
    children: PropTypes.node.isRequired

  getDefaultProps: ->
    isActive: false

  render: ->
    {block, page, isActive, children} = @props

    classes = @classes "#{block}_link", 'm-active': isActive

    <Link className={classes} to="ratings" params={{ page }}>
      {children}
    </Link>

module.exports = PaginationLink
