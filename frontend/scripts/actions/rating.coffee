_ = require 'lodash'
ReduxActions = require 'redux-actions'
itemFetcher = require '../helpers/actions/item_fetcher'
http = require '../helpers/http'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

changeRating = createAction 'CHANGE_RATING'
changeRatingUpdateStatus = createAction 'CHANGE_RATING_UPDATE_STATUS'

{fetch: fetchRating} = itemFetcher name: 'rating', url: ({args}) -> "ratings/#{args[0]}"

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
    data = toFormData rating: deepSnakecaseKeys(changes)

    http.put("ratings/#{rating.item.id}", data).then ({data}) ->
      notSync = notSync() if _.isFunction notSync
      notSync = _.keys changes if notSync == true
      changes = _.omit data.rating, notSync
      dispatch changeRating(changes)

removeRating = (id) ->
  (dispatch, getState) ->
    id ||= getState().rating.id

    http.delete("ratings/#{id}").then ->
      dispatch { type: 'REMOVE_RATING', payload: id }

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

likeRating = (ratingId) ->
  (dispatch, getState) ->
    ratingId ||= getState().rating.id

    http.post("ratings/#{ratingId}/likes").then ({data}) ->
      dispatch changeRating(like: data.like, likesCount: data.meta.likesCount)

unlikeRating = (ratingId) ->
  (dispatch, getState) ->
    ratingId ||= getState().rating.id

    http.delete("ratings/#{ratingId}/likes").then ({data}) ->
      dispatch changeRating(like: null, likesCount: data.meta.likesCount)

module.exports = { fetchRating, viewRating, changeRating, createRating,
  updateRating, removeRating, changeRatingUpdateStatus, addTagToRating,
  removeTagFromRating, likeRating, unlikeRating }
