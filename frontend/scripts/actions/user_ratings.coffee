ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

{fetch: fetchUserRatings} = paginatedItemsFetcher
  name: 'userRatings'
  url: ({args}) -> "users/#{args[0]}/ratings"
  responseKey: 'ratings'
  getPage: (args) -> args[1]
  getSlugFromState: (state) -> state.user.item.slug
  getSlugFromArgs: (args) -> args[0]

module.exports = { fetchUserRatings }
