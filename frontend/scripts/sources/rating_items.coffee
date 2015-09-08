Marty = require 'marty'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingItemsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/ratings'

  loadForRating: (ratingId) ->
    url = "#{ratingId}/rating_items"
    @get url

  create: (ratingId, data) ->
    url = "#{ratingId}/rating_items"
    body = toFormData rating_item: deepSnakecaseKeys(data)
    @post { url, body }

  update: (id, ratingId, changes) ->
    url = "#{ratingId}/rating_items/#{id}"
    body = toFormData rating_item: deepSnakecaseKeys(changes)
    @put { url, body }

  remove: (id, ratingId) ->
    url = "#{ratingId}/rating_items/#{id}"
    @delete { url }

module.exports = RatingItemsApi
