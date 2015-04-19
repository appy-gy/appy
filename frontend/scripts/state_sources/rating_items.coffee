Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class RatingItemsApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  update: (id, changes) ->
    url = "rating_items/#{id}"
    body = toFormData ratingItem: snakecaseKeys(changes)
    @put { url, body }

module.exports = Marty.register RatingItemsApi
