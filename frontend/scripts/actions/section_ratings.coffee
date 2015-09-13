ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestSectionRatings = createAction 'REQUEST_SECTION_RATINGS'
receiveSectionRatings = createAction 'RECEIVE_SECTION_RATINGS'
setSectionRatingsPagesCount = createAction 'SET_SECTION_RATINGS_PAGES_COUNT'

fetchSectionRatings = (sectionId, page) ->
  (dispatch, getState) ->
    dispatch requestSectionRatings()

    axios.get("sections/#{sectionId}/ratings", params: { page }).then ({data}) ->
      data.ratings.each (rating) -> rating.page = page
      dispatch receiveSectionRatings(data.ratings)
      dispatch setSectionRatingsPagesCount(data.meta.pagesCount)

module.exports = { fetchSectionRatings }