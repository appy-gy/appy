ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestUserRatings = createAction 'REQUEST_USER_RATINGS'
receiveUserRatings = createAction 'RECEIVE_USER_RATINGS'
setUserRatingsPagesCount = createAction 'SET_USER_RATINGS_PAGES_COUNT'

fetchUserRatings = (userId, page) ->
  (dispatch, getState) ->
    dispatch requestUserRatings()

    axios.get("users/#{userId}/ratings", params: { page }).then ({data}) ->
      data.ratings.each (rating) -> rating.page = page
      dispatch receiveUserRatings(data.ratings)
      dispatch setUserRatingsPagesCount(data.meta.pagesCount)

module.exports = { fetchUserRatings }
