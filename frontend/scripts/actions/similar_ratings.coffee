itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchSimilarRatings} = itemsFetcher
  name: 'similarRatings'
  url: (ratingId) -> "ratings/#{ratingId}/similar"
  responseKey: 'ratings'

module.exports = { fetchSimilarRatings }
