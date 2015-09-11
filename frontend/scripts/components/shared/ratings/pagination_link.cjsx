_ = require 'lodash'
React = require 'react/addons'
Link = require '../pagination/link'

{PropTypes} = React

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    loadPage: PropTypes.func.isRequired

  resetVisiblePages: ->
    {page} = @props
    {loadPage} = @context

    loadPage page

  linkProps: ->
    {page} = @props

    to: 'ratings'
    params: { page }
    onClick: @resetVisiblePages

  render: ->
    props = _.merge @linkProps(), @props

    <Link {...props}/>

module.exports = PaginationLink
