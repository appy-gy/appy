itemFetcher = require '../helpers/actions/item_fetcher'

{fetch: fetchPage} = itemFetcher name: 'page', url: ({args}) -> "pages/#{args[0]}"

module.exports = { fetchPage }
