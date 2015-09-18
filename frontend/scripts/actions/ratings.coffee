paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{fetch: fetchRatings} = paginatedItemsFetcher
  name: 'ratings'
  url: -> 'ratings'
  getPage: (args) -> args[0]

module.exports = { fetchRatings }
