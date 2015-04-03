_ = require 'lodash'
Marty = require 'marty'
React = require 'react/addons'
toArray = require '../helpers/to_array'
UsersConstants = require '../constants/users'
UsersQueries = require '../queries/users'
User = require '../models/user'

{update} = React.addons

class UsersStore extends Marty.Store
  constructor: ->
    super
    @state = []
    @handlers =
      append: UsersConstants.APPEND_USERS

  rehydrate: (state) ->
    users = state.map (user) -> new User user
    @append users

  get: (id) ->
    @fetch
      id: "get-#{id}"
      locally: ->
        return unless @hasAlreadyFetched "get-#{id}"
        _.find @state, (user) -> user.id == id
      remotely: ->
        UsersQueries.for(@).get(id)

  append: (users) ->
    @state = update @state, $push: toArray(users)

module.exports = Marty.register UsersStore
