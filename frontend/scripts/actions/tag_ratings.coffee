ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

{fetch: fetchTagRatings} = paginatedItemsFetcher
  name: 'tagRatings'
  url: ({args}) -> "tags/#{args[0]}/ratings"
  responseKey: 'ratings'
  getPage: (args) -> args[1]

module.exports = { fetchTagRatings }
