itemFetcher = require '../helpers/actions/item_fetcher'

{fetch: fetchMainPageRatings} = itemFetcher
  name: 'mainPageRatings'
  url: -> 'main_page_ratings'
  responseKey: 'ratings'

module.exports = { fetchMainPageRatings }
