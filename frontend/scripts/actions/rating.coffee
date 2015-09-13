_ = require 'lodash'
ReduxActions = require 'redux-actions'
axios = require 'axios'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

requestRating = createAction 'REQUEST_RATING'
receiveRating = createAction 'RECEIVE_RATING'
changeRating = createAction 'CHANGE_RATING'
changeRatingUpdateStatus = createAction 'CHANGE_UPDATE_STATUS'

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

updateRating = (changes, notSync) ->
  (dispatch, getState) ->
    {rating} = getState()
    notSync = _.keys changes if notSync == true
    data = toFormData rating: deepSnakecaseKeys(changes)

    axios.put("ratings/#{rating.item.id}", data).then ({data}) ->
      changes = _.omit data.rating, notSync
      dispatch changeRating(changes)

removeRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    axios.delete "ratings/#{rating.item.id}"

addTagToRating = (name) ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch type: 'ADD_TAG_TO_RATING', payload: name
    axios.post "ratings/#{rating.item.id}/tags", { name }

removeTagFromRating = (name) ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch type: 'REMOVE_TAG_FROM_RATING', payload: name
    axios.delete "ratings/#{rating.item.id}/tags", data: { name }

module.exports = { fetchRating, viewRating, changeRating, updateRating,
  removeRating, changeRatingUpdateStatus, addTagToRating, removeTagFromRating }
