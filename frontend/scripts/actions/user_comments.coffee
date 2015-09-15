paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{fetch: fetchUserComments} = paginatedItemsFetcher
  name: 'userComments'
  url: (page, userId) -> "users/#{userId}/comments"
  responseKey: 'comments'

module.exports = { fetchUserComments }
