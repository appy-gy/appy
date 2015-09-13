ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestRating = createAction 'REQUEST_RATING'
receiveRating = createAction 'RECEIVE_RATING'

fetchRating = (id) ->
  (dispatch, getState) ->
    dispatch requestRating()

    axios.get("ratings/#{id}").then ({data}) ->
      dispatch receiveRating(data.rating)

module.exports = { fetchRating }
