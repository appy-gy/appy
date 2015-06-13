_ = require 'lodash'
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

  contextTypes:
    router: PropTypes.func.isRequired

  getDefaultProps: ->
    isActive: false

  linkProps: ->
    {page} = @props
    {router} = @context

    to: 'user'
    params: router.getCurrentParams()
    query: _.defaults { page }, router.getCurrentQuery()

  render: ->
    {block, page, isActive} = @props

    classes = @classes "#{block}_link", 'm-active': isActive

    <Link className={classes} {...@linkProps()}>
      {page}
    </Link>


module.exports = PaginationLink
