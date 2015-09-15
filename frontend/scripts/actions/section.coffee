itemFetcher = require '../helpers/actions/item_fetcher'

{fetch: fetchSection} = itemFetcher name: 'section', url: (id) -> "sections/#{id}"

module.exports = { fetchSection }
