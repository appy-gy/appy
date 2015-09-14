React = require 'react/addons'
ReduxActions = require 'redux-actions'
axios = require 'axios'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{update} = React.addons
{createAction} = ReduxActions

requestRatingItems = createAction 'REQUEST_RATING_ITEMS'
receiveRatingItems = createAction 'RECEIVE_RATING_ITEMS'
appendRatingItem = createAction 'APPEND_RATING_ITEM'
changeRatingItemPositions = createAction 'CHANGE_RATING_ITEM_POSITIONS'
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

changeRatingItem = createAction 'CHANGE_RATING_ITEM', (id, changes) ->
  { id, changes }

updateRatingItem = (id, changes, notSync) ->
  (dispatch, getState) ->
    {rating} = getState()
    notSync = _.keys changes if notSync == true
    data = toFormData deepSnakecaseKeys(ratingItem: changes)

    axios.put("ratings/#{rating.item.id}/rating_items/#{id}", data).then ({data}) ->
      changes = _.omit data.ratingItem, notSync
      dispatch changeRating(id, changes)

removeRatingItem = (id) ->
  (dispatch, getState) ->
    {rating} = getState()

    axios.delete("ratings/#{rating.item.id}/rating_items/#{id}").then ->
      dispatch type: 'REMOVE_RATING_ITEM', payload: id

changeRatingItemPosition = (id, position) ->
  (dispatch, getState) ->
    ratingItems = _.sortBy getState().ratingItems.items, 'position'
    index = _.findIndex ratingItems, (item) -> item.id == id
    afterIndex = _.findIndex ratingItems, (item) -> item.position == position
    ratingItem = ratingItems[index]

    newRatingItems = update ratingItems,
      $splice: [
        [index, 1]
        [afterIndex, 0, ratingItem]
      ]

    positions = _.transform newRatingItems, (result, ratingItem, index) ->
      result[ratingItem.id] = index
    , {}

    dispatch changeRatingItemPositions(positions)

updateRatingItemPositions = ->
  (dispatch, getState) ->
    {rating, ratingItems} = getState()

    url = "ratings/#{rating.item.id}/rating_items/positions"
    positions = _.transform ratingItems.items, (result, {id, position}) ->
      result[id] = position
    , {}

    axios.put(url, { positions }).then ({data}) ->
      dispatch changeRatingItemPositions(data.positions)

voteFromRatingItem = (id, kind) ->
  (dispatch, getState) ->
    axios.post("rating_items/#{id}/votes", vote: { kind }).then ({data}) ->
      dispatch changeRatingItem(id, vote: data.vote, mark: data.meta.mark)

module.exports = { fetchRatingItems, createRatingItem, changeRatingItem,
  updateRatingItem, removeRatingItem, changeRatingItemPositions,
  changeRatingItemPosition, updateRatingItemPositions, markRatingItemVisible,
  unmarkRatingItemVisible, voteFromRatingItem }
