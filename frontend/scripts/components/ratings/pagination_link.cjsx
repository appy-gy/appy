React = require 'react/addons'
Router = require 'react-router'
classNames = require 'classnames'

{PropTypes} = React
{Link} = Router

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    block: PropTypes.string.isRequired
    page: PropTypes.number.isRequired
    isActive: PropTypes.bool.isRequired

  render: ->
    {block, page, isActive} = @props

    classes = classNames "#{block}_link", 'm-active': isActive

    <Link className={classes} to="ratings" params={{ page }}>
      {page}
    </Link>

module.exports = PaginationLink
