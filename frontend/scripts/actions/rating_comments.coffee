ReduxActions = require 'redux-actions'
itemsFetcher = require '../helpers/actions/items_fetcher'
http = require '../helpers/http'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'

{createAction} = ReduxActions

appendRatingComment = createAction 'APPEND_RATING_COMMENT'

{fetch: fetchRatingComments} = itemsFetcher
  name: 'ratingComments',
  url: ({rating}) -> "ratings/#{rating.item.id}/comments"
  responseKey: 'comments'

createRatingComment = (body, parentId) ->
  (dispatch, getState) ->
    {rating} = getState()

    data = comment: deepSnakecaseKeys({ body, parentId })
    http.post("ratings/#{rating.item.id}/comments", data).then ({data}) ->
      dispatch appendRatingComment(data.comment)
      data

module.exports = { fetchRatingComments, createRatingComment }
