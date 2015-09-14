ReduxActions = require 'redux-actions'
axios = require 'axios'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

requestRatingComments = createAction 'REQUEST_RATING_COMMENTS'
receiveRatingComments = createAction 'RECEIVE_RATING_COMMENTS'
appendRatingComment = createAction 'APPEND_RATING_COMMENT'

fetchRatingComments = ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch requestRatingComments()

    axios.get("ratings/#{rating.item.id}/comments").then ({data}) ->
      dispatch receiveRatingComments(data.comments)

createRatingComment = (body, parentId) ->
  (dispatch, getState) ->
    {rating} = getState()

    data = comment: deepSnakecaseKeys({ body, parentId })
    axios.post("ratings/#{rating.item.id}/comments", data).then ({data}) ->
      dispatch appendRatingComment(data.comment)
      data

module.exports = { fetchRatingComments, createRatingComment }
