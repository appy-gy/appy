_ = require 'lodash'
Marty = require 'marty'

class CurrentUserApi extends Marty.HttpStateSource
  baseUrl: '/api/private'

  load: ->
    @get 'sessions'

  logIn: (data) ->
    body = session: _.pick(data, 'email', 'password')
    @post { url: 'sessions', body }

  logOut: ->
    @delete 'sessions'

  register: (data) ->
    body = user: _.pick(data, 'email', 'password')
    @post { url: 'users', body }

module.exports = Marty.register CurrentUserApi
