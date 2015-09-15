itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchSections} = itemsFetcher name: 'sections', url: -> 'sections'

module.exports = { fetchSections }
