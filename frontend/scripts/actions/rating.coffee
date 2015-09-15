_ = require 'lodash'
ReduxActions = require 'redux-actions'
itemFetcher = require '../helpers/actions/item_fetcher'
http = require '../helpers/http'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

changeRating = createAction 'CHANGE_RATING'
changeRatingUpdateStatus = createAction 'CHANGE_UPDATE_STATUS'

{fetch: fetchRating} = itemFetcher name: 'rating', url: (id) -> "ratings/#{id}"

viewRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    return unless rating.item.status == 'published'

    http.put("ratings/#{rating.item.id}/view").then ({data}) ->
      dispatch changeRating(data)

createRating = ->
  (dispatch, getState) ->
    http.post('ratings').then ({data}) ->
      data.rating

updateRating = (changes, notSync) ->
  (dispatch, getState) ->
    {rating} = getState()
    notSync = _.keys changes if notSync == true
    data = toFormData rating: deepSnakecaseKeys(changes)

    http.put("ratings/#{rating.item.id}", data).then ({data}) ->
      changes = _.omit data.rating, notSync
      dispatch changeRating(changes)

removeRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    http.delete "ratings/#{rating.item.id}"

addTagToRating = (name) ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch type: 'ADD_TAG_TO_RATING', payload: name
    http.post "ratings/#{rating.item.id}/tags", { name }

removeTagFromRating = (name) ->
  (dispatch, getState) ->
    {rating} = getState()

    dispatch type: 'REMOVE_TAG_FROM_RATING', payload: name
    http.delete "ratings/#{rating.item.id}/tags", data: { name }

likeRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    http.post("ratings/#{rating.item.id}/likes").then ({data}) ->
      dispatch changeRating(like: data.like, likesCount: data.meta.likesCount)

unlikeRating = ->
  (dispatch, getState) ->
    {rating} = getState()

    http.delete("ratings/#{rating.item.id}/likes").then ({data}) ->
      dispatch changeRating(like: null, likesCount: data.meta.likesCount)

module.exports = { fetchRating, viewRating, changeRating, createRating,
  updateRating, removeRating, changeRatingUpdateStatus, addTagToRating,
  removeTagFromRating, likeRating, unlikeRating }
