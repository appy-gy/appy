ReduxActions = require 'redux-actions'
axios = require 'axios'

{createAction} = ReduxActions

requestSimilarRatings = createAction 'REQUEST_SIMILAR_RATINGS'
receiveSimilarRatings = createAction 'RECEIVE_SIMILAR_RATINGS'

fetchSimilarRatings = ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch requestSimilarRatings()

    axios.get("ratings/#{rating.item.id}/similar").then ({data}) ->
      dispatch receiveSimilarRatings(data.ratings)

module.exports = { fetchSimilarRatings }
