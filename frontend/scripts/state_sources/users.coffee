Marty = require 'marty'

class UsersApi extends Marty.HttpStateSource
  baseUrl: '/api/private/users'

  load: (id) ->
    @get id

module.exports = Marty.register UsersApi
