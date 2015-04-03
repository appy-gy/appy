Marty = require 'marty'
snakecaseKeys = require '../helpers/snakecase_keys'

class UsersApi extends Marty.HttpStateSource
  baseUrl: '/api/private/users'

  load: (id) ->
    @get id

  update: (user) ->
    body = user: snakecaseKeys user
    @put { url: user.id, body }

module.exports = Marty.register UsersApi
