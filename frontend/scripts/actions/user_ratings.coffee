paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{fetch: fetchUserRatings} = paginatedItemsFetcher
  name: 'userRatings'
  url: (page, userId) -> "users/#{userId}/ratings"
  responseKey: 'ratings'

module.exports = { fetchUserRatings }
