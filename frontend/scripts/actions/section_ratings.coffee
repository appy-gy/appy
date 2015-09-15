paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{fetch: fetchSectionRatings} = paginatedItemsFetcher
  name: 'sectionRatings'
  url: (page, sectionId) -> "sections/#{sectionId}/ratings"
  responseKey: 'ratings'

module.exports = { fetchSectionRatings }
