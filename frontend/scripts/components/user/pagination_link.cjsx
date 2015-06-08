_ = require 'lodash'
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

  contextTypes:
    router: PropTypes.func.isRequired

  linkProps: ->
    {page} = @props
    {router} = @context

    to: 'user'
    params: router.getCurrentParams()
    query: _.defaults { page }, router.getCurrentQuery()

  render: ->
    {block, page, isActive} = @props

    classes = classNames "#{block}_link", 'm-active': isActive

    <Link className={classes} {...@linkProps()}>
      {page}
    </Link>


module.exports = PaginationLink
