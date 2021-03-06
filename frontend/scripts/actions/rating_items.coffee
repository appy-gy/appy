_ = require 'lodash'
update = require 'react-addons-update'
ReduxActions = require 'redux-actions'
itemsFetcher = require '../helpers/actions/items_fetcher'
http = require '../helpers/http'
toFormData = require '../helpers/to_form_data'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

appendRatingItem = createAction 'APPEND_RATING_ITEM'
changeRatingItemPositions = createAction 'CHANGE_RATING_ITEM_POSITIONS'
changeRatingItemsOrder = createAction 'CHANGE_RATING_ITEMS_ORDER'

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
      notSync = notSync() if _.isFunction notSync
      notSync = _.keys changes if notSync == true
      changes = _.omit data.ratingItem, notSync
      dispatch changeRatingItem(id, changes)

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

    http.put(url, { positions }).then ({originalData}) ->
      dispatch changeRatingItemPositions(originalData.positions)

changeRatingItemWaypoint = createAction 'CHANGE_RATING_ITEM_WAYPOINT'

voteForRatingItem = (id, kind) ->
  (dispatch, getState) ->
    {ratingItems} = getState()

    item = _.find ratingItems.items, (item) -> item.id == id
    prevVote = item.vote
    prevMark = item.mark
    change = if kind == 'up' then 1 else -1
    change *= 2 if prevVote
    dispatch changeRatingItem(id, vote: { ratingItemId: id, kind }, mark: item.mark + change)

    http.post "rating_items/#{id}/votes", vote: { kind }
      .then ({data}) ->
        dispatch changeRatingItem(id, vote: data.vote, mark: data.meta.mark)
      .catch ->
        dispatch changeRatingItem(id, vote: prevVote, mark: prevMark)

module.exports = { fetchRatingItems, createRatingItem, changeRatingItem,
  updateRatingItem, removeRatingItem, changeRatingItemPositions,
  changeRatingItemPosition, updateRatingItemPositions, voteForRatingItem,
  changeRatingItemsOrder, changeRatingItemWaypoint}
