ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestRatingItems = createAction 'REQUEST_RATING_ITEMS'
receiveRatingItems = createAction 'RECEIVE_RATING_ITEMS'
markRatingItemVisible = createAction 'MARK_RATING_ITEM_VISIBLE'
unmarkRatingItemVisible = createAction 'UNMARK_RATING_ITEM_VISIBLE'

fetchRatingItems = (ratingId) ->
  (dispatch, getState) ->
    dispatch requestRatingItems()

    axios.get("ratings/#{ratingId}/rating_items").then ({data}) ->
      dispatch receiveRatingItems(data.ratingItems)

module.exports = { fetchRatingItems }
