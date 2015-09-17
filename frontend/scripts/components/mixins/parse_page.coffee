_ = require 'lodash'
React = require 'react'

{PropTypes} = React

defaultPage = 1

ParsePage =
  propTypes:
    page: PropTypes.oneOfType([PropTypes.number, PropTypes.string])

  getDefaultProps: ->
    page: null

  parsePage: (page) ->
    return defaultPage unless page?
    return page if _.isNumber page
    page = parseInt page.match(/\d+$/)?[0]
    return defaultPage if isNaN page
    page

  page: ->
    {page} = @props

    @parsePage page

module.exports = ParsePage
