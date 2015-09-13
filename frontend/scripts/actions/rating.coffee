ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestRating = createAction 'REQUEST_RATING'
receiveRating = createAction 'RECEIVE_RATING'
changeRating = createAction 'CHANGE_RATING'

fetchRating = (id) ->
  (dispatch, getState) ->
    dispatch requestRating()

    axios.get("ratings/#{id}").then ({data}) ->
      dispatch receiveRating(data.rating)

viewRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    return unless rating.item.status == 'published'

    axios.put("ratings/#{rating.item.id}/view").then ({data}) ->
      dispatch changeRating(data)

module.exports = { fetchRating, viewRating }
