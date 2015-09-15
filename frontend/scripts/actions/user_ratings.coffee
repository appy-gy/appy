ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

clearUserRatings = createAction 'CLEAR_USER_RATINGS'

{fetch: fetchUserRatings} = paginatedItemsFetcher
  name: 'userRatings'
  url: (page, userId) -> "users/#{userId}/ratings"
  responseKey: 'ratings'

module.exports = { fetchUserRatings, clearUserRatings }
