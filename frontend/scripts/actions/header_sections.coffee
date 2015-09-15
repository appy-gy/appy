itemsFetcher = require '../helpers/actions/items_fetcher'

{fetch: fetchHeaderSections} = itemsFetcher
  name: 'headerSections'
  url: -> 'header_sections'
  responseKey: 'sections'

module.exports = { fetchHeaderSections }
