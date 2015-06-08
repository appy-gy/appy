_ = require 'lodash'

defaultPage = 1

ParsePage =
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
