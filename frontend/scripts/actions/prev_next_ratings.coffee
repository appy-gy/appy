itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchPrevNextRatings} = itemsFetcher
  name: 'prevNextRatings'
  url: ({args}) -> "ratings/#{args[0]}/prev_next"
  responseKey: 'ratings'

module.exports = { fetchPrevNextRatings }
