_ = require 'lodash'
React = require 'react'
Link = require '../shared/pagination/link'

{PropTypes} = React

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    router: PropTypes.func.isRequired

  linkProps: ->
    {page} = @props
    {router} = @context

    to: 'user'
    params: router.getCurrentParams()
    query: _.defaults { page }, router.getCurrentQuery()

  render: ->
    props = _.merge @linkProps(), @props

    <Link {...props}/>

module.exports = PaginationLink
