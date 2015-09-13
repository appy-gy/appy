ReduxActions = require 'redux-actions'
axios = require 'axios'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

requestRatingItems = createAction 'REQUEST_RATING_ITEMS'
receiveRatingItems = createAction 'RECEIVE_RATING_ITEMS'
appendRatingItem = createAction 'APPEND_RATING_ITEM'
markRatingItemVisible = createAction 'MARK_RATING_ITEM_VISIBLE'
unmarkRatingItemVisible = createAction 'UNMARK_RATING_ITEM_VISIBLE'

fetchRatingItems = (ratingId) ->
  (dispatch, getState) ->
    dispatch requestRatingItems()

    axios.get("ratings/#{ratingId}/rating_items").then ({data}) ->
      dispatch receiveRatingItems(data.ratingItems)

createRatingItem = (position) ->
  (dispatch, getState) ->
    {rating} = getState()
    data = toFormData deepSnakecaseKeys(ratingItem: { position })

    axios.post("ratings/#{rating.item.id}/rating_items", data).then ({data}) ->
      dispatch appendRatingItem(data.ratingItem)

module.exports = { fetchRatingItems, createRatingItem }
