itemFetcher = require '../helpers/actions/item_fetcher'

{fetch: fetchTag} = itemFetcher
  name: 'tag'
  url: ({args}) -> "tags/#{args[0]}"

module.exports = { fetchTag }
