ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

{fetch: fetchSectionRatings} = paginatedItemsFetcher
  name: 'sectionRatings'
  url: ({args}) -> "sections/#{args[0]}/ratings"
  responseKey: 'ratings'
  getPage: (args) -> args[1]

module.exports = { fetchSectionRatings }
