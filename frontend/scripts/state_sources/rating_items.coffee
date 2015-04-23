Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingItemsApi extends Marty.HttpStateSource
  baseUrl: '/api/private/ratings'

  update: (item, changes) ->
    url = "#{item.ratingId}/rating_items/#{item.id}"
    body = toFormData rating_item: snakecaseKeys(changes)
    @put { url, body }

  create: (item, changes) ->
    url = "#{item.ratingId}/rating_items"
    body = toFormData rating_item: snakecaseKeys(changes)
    @post { url, body }

  loadForRating: (ratingId) ->
    url = "#{ratingId}/rating_items"
    @get url

module.exports = Marty.register RatingItemsApi
