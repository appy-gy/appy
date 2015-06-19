_ = require 'lodash'
React = require 'react/addons'
Link = require '../shared/pagination/link'

{PropTypes} = React

PaginationLink = React.createClass
  displayName: 'PaginationLink'

  propTypes:
    page: PropTypes.number.isRequired

  linkProps: ->
    {page} = @props

    to: 'ratings'
    params: { page }

  render: ->
    props = _.merge @linkProps() , @props

    <Link  {...props}/>

module.exports = PaginationLink
