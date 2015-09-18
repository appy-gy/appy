itemFetcher = require '../helpers/actions/item_fetcher'

{fetch: fetchSection} = itemFetcher
  name: 'section'
  url: ({args}) -> "sections/#{args[0]}"

module.exports = { fetchSection }
