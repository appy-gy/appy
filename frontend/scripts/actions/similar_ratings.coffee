itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchSimilarRatings} = itemsFetcher
  name: 'similarRatings'
  url: ({args}) -> "ratings/#{args[0]}/similar"
  responseKey: 'ratings'

module.exports = { fetchSimilarRatings }
