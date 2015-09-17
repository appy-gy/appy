_ = require 'lodash'
React = require 'react'
ReactRedux = require 'react-redux'
Link = require '../pagination/link'

{PropTypes} = React
{connect} = ReactRedux

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    page: PropTypes.number.isRequired
    pathname: PropTypes.string.isRequired
    query: PropTypes.object.isRequired

  contextTypes:
    loadPage: PropTypes.func.isRequired

  resetVisiblePages: ->
    @context.loadPage @props.page

  linkProps: ->
    {page, pathname, query} = @props

    to: pathname
    query: _.defaults { page }, query
    onClick: @resetVisiblePages

  render: ->
    props = _.merge @linkProps(), _.omit(@props, 'page', 'pathname', 'query')

    <Link {...props}/>

mapStateToProps = ({router}) ->
  _.pick router.location, 'pathname', 'query'

module.exports = connect(mapStateToProps)(PaginationLink)
