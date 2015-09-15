ReduxActions = require 'redux-actions'
paginatedItemsFetcher = require '../helpers/actions/paginated_items_fetcher'

{createAction} = ReduxActions

clearSectionRatings = createAction 'CLEAR_SECTION_RATINGS'

{fetch: fetchSectionRatings} = paginatedItemsFetcher
  name: 'sectionRatings'
  url: (page, sectionId) -> "sections/#{sectionId}/ratings"
  responseKey: 'ratings'

module.exports = { fetchSectionRatings, clearSectionRatings }
