Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'
toFormData = require '../helpers/to_form_data'

class UsersApi extends Marty.HttpStateSource
  baseUrl: '/api/private/users'

  load: (id) ->
    @get id

  update: (id, changes) ->
    body = toFormData(user: snakecaseKeys(changes))
    @put { url: id, body }

module.exports = UsersApi