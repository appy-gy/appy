ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestRatings = createAction 'REQUEST_RATINGS'
receiveRatings = createAction 'RECEIVE_RATINGS'
setRatingsPagesCount = createAction 'SET_RATINGS_PAGES_COUNT'
clearRatings = createAction 'CLEAR_RATINGS'

fetchRatings = (page) ->
  (dispatch, getState) ->
    dispatch requestRatings()

    axios.get('ratings', params: { page }).then ({data, ok}) ->
      return unless ok
      data.ratings.each (rating) -> rating.page = page
      dispatch receiveRatings(data.ratings)
      dispatch setRatingsPagesCount(data.meta.pagesCount)

module.exports = { fetchRatings, clearRatings }
