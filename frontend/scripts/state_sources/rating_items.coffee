Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingItemsApi extends Marty.HttpStateSource
  @id: 'RatingItemsApi'

  baseUrl: '/api/private/ratings'

  loadForRating: (ratingId) ->
    url = "#{ratingId}/rating_items"
    @get url

  create: (ratingId, data) ->
    url = "#{ratingId}/rating_items"
    body = toFormData rating_item: snakecaseKeys(data)
    @post { url, body }

  update: (id, ratingId, changes) ->
    url = "#{ratingId}/rating_items/#{id}"
    body = toFormData rating_item: snakecaseKeys(changes)
    @put { url, body }

  updatePositions: (ratingId, positions) ->
    url = "#{ratingId}/rating_items/positions"
    body = { positions }
    @put { url, body }

module.exports = Marty.register RatingItemsApi
