paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{fetch: fetchRatings} = paginatedItemsFetcher name: 'ratings', url: -> 'ratings'

module.exports = { fetchRatings }
