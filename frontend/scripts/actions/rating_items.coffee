update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemsFetcher = require '../helpers/actions/items_fetcher'
http = require '../helpers/http'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

appendRatingItem = createAction 'APPEND_RATING_ITEM'
changeRatingItemPositions = createAction 'CHANGE_RATING_ITEM_POSITIONS'

{fetch: fetchRatingItems} = itemsFetcher
  name: 'ratingItems',
  url: ({args}) -> "ratings/#{args[0]}/rating_items"

createRatingItem = (position) ->
  (dispatch, getState) ->
    {rating} = getState()
    data = toFormData deepSnakecaseKeys(ratingItem: { position })

    http.post("ratings/#{rating.item.id}/rating_items", data).then ({data}) ->
      dispatch appendRatingItem(data.ratingItem)

changeRatingItem = createAction 'CHANGE_RATING_ITEM', (id, changes) ->
  { id, changes }

updateRatingItem = (id, changes, notSync) ->
  (dispatch, getState) ->
    {rating} = getState()
    notSync = _.keys changes if notSync == true
    data = toFormData deepSnakecaseKeys(ratingItem: changes)

    http.put("ratings/#{rating.item.id}/rating_items/#{id}", data).then ({data}) ->
      changes = _.omit data.ratingItem, notSync
      dispatch changeRating(id, changes)

removeRatingItem = (id) ->
  (dispatch, getState) ->
    {rating} = getState()

    http.delete("ratings/#{rating.item.id}/rating_items/#{id}").then ->
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

    http.put(url, { positions }).then ({data}) ->
      dispatch changeRatingItemPositions(data.positions)

changeRatingItemVisibility = createAction 'CHANGE_RATING_ITEM_VISIBILITY', (id, visibility) ->
  { id, visibility }

addRatingItemWaypoint = createAction 'ADD_RATING_ITEM_WAYPOINT', (id, visibility) ->
  { id, visibility }

removeRatingItemWaypoint = createAction 'REMOVE_RATING_ITEM_WAYPOINT'

voteFromRatingItem = (id, kind) ->
  (dispatch, getState) ->
    http.post("rating_items/#{id}/votes", vote: { kind }).then ({data}) ->
      dispatch changeRatingItem(id, vote: data.vote, mark: data.meta.mark)

module.exports = { fetchRatingItems, createRatingItem, changeRatingItem,
  updateRatingItem, removeRatingItem, changeRatingItemPositions,
  changeRatingItemPosition, updateRatingItemPositions,
  changeRatingItemVisibility, voteFromRatingItem, addRatingItemWaypoint, removeRatingItemWaypoint }
