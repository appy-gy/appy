_ = require 'lodash'
React = require 'react/addons'
Link = require '../shared/pagination/link'

{PropTypes} = React

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    page: PropTypes.number.isRequired

  contextTypes:
    changeVisiblePages: PropTypes.func.isRequired

  resetVisiblePages: ->
    {page} = @props
    {changeVisiblePages} = @context

    changeVisiblePages -> new Set [page]

  linkProps: ->
    {page} = @props

    to: 'ratings'
    params: { page }
    onClick: @resetVisiblePages

  render: ->
    props = _.merge @linkProps(), @props

    <Link {...props}/>

module.exports = PaginationLink
