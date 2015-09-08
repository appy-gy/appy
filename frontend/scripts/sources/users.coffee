Marty = require 'marty'
deepSnakecaseKeys = require '../helpers/deep_snakecase_keys'
toFormData = require '../helpers/to_form_data'

class UsersApi extends Marty.HttpStateSource
  baseUrl: '/api/private/users'

  load: (id) ->
    @get id

  update: (id, changes) ->
    body = toFormData(user: deepSnakecaseKeys(changes))
    @put { url: id, body }

  changePassword: (id, oldPassword, newPassword) ->
    url = "#{id}/change_password"
    body = deepSnakecaseKeys { oldPassword, newPassword }
    @put { url, body }

module.exports = UsersApi
